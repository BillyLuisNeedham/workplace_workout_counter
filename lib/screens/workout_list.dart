import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/custom_widgets/workout_list_tile.dart';
import 'package:workplace_workout_counter/utils/database.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/screens/complete_workout.dart';

class WorkoutList extends StatefulWidget {

  final String day;

  WorkoutList({this.day});

  @override
  _WorkoutListState createState() => _WorkoutListState(this.day);
}

class _WorkoutListState extends State<WorkoutList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Workout> workoutList;
  int count = 0;

  final String day;
  _WorkoutListState(this.day);
  @override
  Widget build(BuildContext context) {
    if (workoutList == null) {
      workoutList = List<Workout>();
      updateListView();
    }

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          this.day,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: getWorkoutListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAdd(Workout(day: this.day));
        },
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add, size: 50, color: Colors.amber[200]),
      ),
    );
  }

  ListView getWorkoutListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: WorkoutListTile(
                workout: workoutList[position],
                onTap: () {
                  navigateToComplete(this.workoutList[position]);
                },
              )),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void navigateToAdd(Workout workout) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddWorkout(workout: workout);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToComplete(Workout workout) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CompleteWorkout(workout: workout, appBarTitle: workout.title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    print("updateListView fired");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Workout>> workoutListFuture = databaseHelper.getAllDayWorkouts(this.day);
      workoutListFuture.then((workoutList) {
        setState(() {
          this.workoutList = workoutList;
          this.count = workoutList.length;
        });
      });
    });
  }
}


