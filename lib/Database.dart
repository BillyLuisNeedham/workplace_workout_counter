import 'dart:async';
import 'dart:io';

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
        "$colRemainingReps TEXT"
        ")");
  }

  //fetch operation get all workouts from database
  Future<List<Map<String, dynamic>>> getWorkoutMapList() async {
    Database db = await this.database;
    var result = await db.query(workoutTable, orderBy: "$colTitle ASC");
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
  Future<List<Workout>> getAllWorkouts() async {
    var workoutMapList = await getWorkoutMapList(); //get map list from database
    int count = workoutMapList.length;

    List<Workout> workoutList = List<Workout>();
    //for loop to create workout list from map list
    for (int i = 0; i < count; i++) {
      workoutList.add(Workout.fromMap(workoutMapList[i]));
    }

    return workoutList;
  }

  //get number of workout objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $workoutTable');
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
    int result = await db.rawDelete('DELETE FROM $workoutTable WHERE $colId = $id');
    return result;
  }

  deleteAllWorkouts() async {
    final db = await database;
    db.rawDelete("Delete * from Workout");
  }
}
