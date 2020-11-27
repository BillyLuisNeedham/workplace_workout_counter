import 'dart:async';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String workoutTable = 'Workout';
  String colId = 'id';
  String colTitle = "title";
  String colDailyReps = "daily_reps";
  String colRemainingReps = 'remaining_reps';
  String colLastUpdated = 'last_updated';
  String colDay = 'day';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DBProvider

  factory DatabaseHelper() {
    if (_database == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //get the directory path
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'workouts.db';

    var workoutDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return workoutDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $workoutTable ("
        "$colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colTitle TEXT,"
        "$colDailyReps TEXT,"
        "$colRemainingReps TEXT,"
        "$colLastUpdated TEXT,"
        "$colDay TEXT"
        ")");
  }

  //fetch operation get all workouts from database
  Future<List<Map<String, dynamic>>> getAllWorkoutMapList() async {
    Database db = await this.database;
    var result = await db.query(workoutTable, orderBy: "$colTitle ASC");
    return result;
  }

  //fetch all workouts that match the day
  Future<List<Map<String, dynamic>>> getAllDayWorkoutMapList(String day) async {
    Database db = await this.database;
    var result =
        await db.query(workoutTable, where: '$colDay = ?', whereArgs: [day]);
    return result;
  }

  //insert a workout into database
  Future<int> newWorkout(Workout newWorkout) async {
    Database db = await this.database;
    var result = await db.insert(workoutTable, newWorkout.toMap());
    return result;
  }

  //fetch a workout from the database
  Future<Workout> getWorkout(int id) async {
    final db = await this.database;
    var res =
        await db.query(workoutTable, where: "$colId = ?", whereArgs: [id]);
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
    workoutList = workoutListRemainingRepsHandler(workoutList);

    return workoutList;
  }

  //check if workout last updated today and if not reset remaining reps
  List<Workout> workoutListRemainingRepsHandler(List<Workout> workoutList) {
    String now = DateFormat.yMMMd().format(DateTime.now());

    //if last completed isn't today, reset remaining reps
    for (var workout in workoutList) {
      if (workout.lastUpdated != now) {
        workout.lastUpdated = now;
      }
    }

    return workoutList;
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
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $workoutTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //update workout and save it to database
  Future<int> updateWorkout(Workout newWorkout) async {
    final db = await this.database;
    var res = await db.update(workoutTable, newWorkout.toMap(),
        where: "$colId = ?", whereArgs: [newWorkout.id]);
    return res;
  }

  //delete workout in database
  Future<int> deleteWorkout(int id) async {
    final db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $workoutTable WHERE $colId = $id');
    return result;
  }

  //delete all workouts in database
  Future<int> deleteAllWorkouts() async {
    final db = await this.database;
    int result = await db.rawDelete("Delete * from Workout");
    return result;
  }
}
