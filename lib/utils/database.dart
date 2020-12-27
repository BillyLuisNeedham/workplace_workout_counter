import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String workoutTable = 'Workout';
  String colId = 'id';
  String colTitle = "title";
  String colDailyReps = "daily_reps";
  String colRemainingReps = 'remaining_reps';
  String colLastUpdated = 'last_updated';
  String colSecondsPerRep = 'seconds_per_rep';
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
        await openDatabase(path, version: 2, onCreate: _createDb);
    return workoutDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $workoutTable ("
        "$colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colTitle TEXT,"
        "$colDailyReps TEXT,"
        "$colRemainingReps TEXT,"
        "$colLastUpdated TEXT,"
        "$colSecondsPerRep INTEGER,"
        "$colDay TEXT"
        ")");
  }

}
