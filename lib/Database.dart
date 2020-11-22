import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    //if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "WorkoutDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Workout ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "daily_reps INTEGER,"
          "remaining_reps INTEGER"
          ")");
    });
  }

  newWorkout(Workout newWorkout) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Workout");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Workout (id,title,daily_reps,remaining_reps)"
        " VALUES (?,?,?,?)",
        [id, newWorkout.title, newWorkout.dailyReps, newWorkout.dailyReps]);
    return raw;
  }

  getWorkout(int id) async {
    final db = await database;
    var res = await db.query("Workout", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Workout.fromMap(res.first) : Null;
  }

  getAllWorkouts() async {
    final db = await database;
    var res = await db.query("Workout");
    List<Workout> list = res.isNotEmpty ? res.map((e) => Workout.fromMap(e)).toList() : [];
    return list;
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
