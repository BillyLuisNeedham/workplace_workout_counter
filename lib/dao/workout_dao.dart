import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/utils/database.dart';

class WorkoutDao {
  final dbHelper = DatabaseHelper();


  //fetch operation get all workouts from database
  Future<List<Map<String, dynamic>>> getAllWorkoutMapList() async {
    Database db = await dbHelper.database;
    var result = await db.query(dbHelper.workoutTable, orderBy: "${dbHelper.colTitle} ASC");
    return result;
  }

  //fetch all workouts that match the day
  Future<List<Map<String, dynamic>>> getAllDayWorkoutMapList(String day) async {
    Database db = await dbHelper.database;
    var result =
    await db.query(dbHelper.workoutTable, where: '${dbHelper.colDay} = ?', whereArgs: [day]);
    return result;
  }

  //insert a workout into database
  Future<int> newWorkout(Workout newWorkout) async {
    Database db = await dbHelper.database;
    var result = await db.insert(dbHelper.workoutTable, newWorkout.toMap());
    return result;
  }

  //fetch a workout from the database
  Future<Workout> getWorkout(int id) async {
    final db = await dbHelper.database;
    var res =
    await db.query(dbHelper.workoutTable, where: "${dbHelper.colId} = ?", whereArgs: [id]);
    return res.isNotEmpty ? Workout.fromMap(res.first) : Null;
  }

  //get the map list and convert it to a workout list
  Future<List<Workout>> getAllDayWorkouts(String day) async {
    var workoutMapList = await getAllDayWorkoutMapList(day);
    int count = workoutMapList.length;

    List<Workout> workoutList = List<Workout>();
    //loop through map list and map to workout list
    for (int i = 0; i < count; i++) {
      workoutList.add(Workout.fromMap(workoutMapList[i]));
    }

    //reset remaining reps if required
    List<Workout> workoutListDateHandled =
    workoutListRemainingRepsHandler(workoutList);

    return workoutListDateHandled;
  }

  //auto increment a workout
  Workout workoutAutoIncrement(Workout workout) {
    int remReps = int.parse(workout.remainingReps);
    if (remReps < 1) {
      int dailyReps = int.parse(workout.dailyReps);
      int newDailyReps = (dailyReps / 100 * 5 + dailyReps).round();
      print("newDailyReps: $newDailyReps");
      workout.dailyReps = newDailyReps.toString();
    }
    return workout;
  }

  //check if workout last updated today and if not reset remaining reps
  List<Workout> workoutListRemainingRepsHandler(List<Workout> workoutList) {
    String now = DateFormat.yMMMd().format(DateTime.now());

    List<Workout> newWorkoutList = [];

    //if last completed isn't today, reset remaining reps
    for (var workout in workoutList) {
      if (workout.lastUpdated != now) {
        Workout newWorkout = workoutAutoIncrement(workout);
        newWorkout.lastUpdated = now;
        newWorkout.remainingReps = workout.dailyReps;
        newWorkoutList.add(newWorkout);
      } else {
        newWorkoutList.add(workout);
      }
    }

    return newWorkoutList;
  }

  //get the map list and convert it to a workout list
  Future<List<Workout>> getAllWorkouts() async {
    var workoutMapList =
    await getAllWorkoutMapList(); //get map list from database
    int count = workoutMapList.length;

    List<Workout> workoutList = List<Workout>();
    //for loop to create workout list from map list
    for (int i = 0; i < count; i++) {
      workoutList.add(Workout.fromMap(workoutMapList[i]));
    }

    //reset remaining reps if required
    workoutList = workoutListRemainingRepsHandler(workoutList);

    return workoutList;
  }

  //get number of workout objects in database
  Future<int> getCount() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from ${dbHelper.workoutTable}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //update workout and save it to database
  Future<int> updateWorkout(Workout newWorkout) async {
    final db = await dbHelper.database;
    var res = await db.update(dbHelper.workoutTable, newWorkout.toMap(),
        where: "${dbHelper.colId} = ?", whereArgs: [newWorkout.id]);
    return res;
  }

  //delete workout in database
  Future<int> deleteWorkout(int id) async {
    final db = await dbHelper.database;
    int result =
    await db.rawDelete('DELETE FROM ${dbHelper.workoutTable} WHERE ${dbHelper.colId} = $id');
    return result;
  }

  //delete all workouts in database
  Future<int> deleteAllWorkouts() async {
    final db = await dbHelper.database;
    int result = await db.rawDelete("Delete * from Workout");
    return result;
  }
}