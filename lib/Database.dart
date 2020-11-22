import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class DBProvider {
  static DBProvider _dbProvider;
  static Database _database;

  String workoutTable = 'Workout';
  String colId = 'id';

  DBProvider._createInstance(); // Named constructor to create instance of DBProvider

  factory DBProvider() {
    if (_database == null) {
      _dbProvider = DBProvider._createInstance();
    }
    return _dbProvider;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "workoutDB.db";

    var workoutDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return workoutDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $workoutTable ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title TEXT,"
        "daily_reps INTEGER,"
        "remaining_reps INTEGER"
        ")");
  }

  Future<List<Map<String, dynamic>>> getWorkoutMapList() async {
    Database db = await this.database;
    var result = await db.query(workoutTable, orderBy: "id ASC");
    return result;
  }

  Future<int> newWorkout(Workout newWorkout) async {
    Database db = await this.database;
    var result = await db.insert(workoutTable, newWorkout.toMap());
    return result;
  }

  getWorkout(int id) async {
    final db = await database;
    var res = await db.query("Workout", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Workout.fromMap(res.first) : Null;
  }

  Future<List<Workout>> getAllWorkouts() async {
    var workoutMapList = await getWorkoutMapList(); //get map list from database
    int count = workoutMapList.length;

    List<Workout> workoutList = List<Workout>();
    //for loop to create workout list from map list
    for (int i = 0; 0 < count; i++) {
      workoutList.add(Workout.fromMap(workoutMapList[i]));
    }

    return workoutList;
    // final db = await database;
    // var res = await db.query("Workout");
    // List<Workout> list = res.isNotEmpty ? res.map((e) => Workout.fromMap(e)).toList() : [];
    // return list;
  }

  updateWorkout(Workout newWorkout) async {
    final db = await database;
    var res = await db.update("Workout", newWorkout.toMap(),
        where: "id = ?", whereArgs: [newWorkout.id]);
    return res;
  }

  deleteWorkout(int id) async {
    final db = await database;
    db.delete("Workout", where: "id = ?", whereArgs: [id]);
  }

  deleteAllWorkouts() async {
    final db = await database;
    db.rawDelete("Delete * from Workout");
  }
}
