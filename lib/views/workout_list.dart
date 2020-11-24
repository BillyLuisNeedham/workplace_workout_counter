import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/custom_widgets/custom_list_tile.dart';
import 'package:workplace_workout_counter/utils/database.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/views/add_workout.dart';
import 'package:workplace_workout_counter/views/complete_workout.dart';

class WorkoutList extends StatefulWidget {
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Workout> workoutList;
  int count = 0;

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
          'Workouts',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: getWorkoutListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAdd(Workout());
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
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: CustomListTile(
              workout: workoutList[position],
              onTap: () {
                navigateToComplete(this.workoutList[position]);
              },
            ));
      },
    );
  }

  // ListTile(
// leading: CircleAvatar(
// backgroundColor: Colors.amber,
// child: Text(getFirstLetter(this.workoutList[position].title),
// style: TextStyle(fontWeight: FontWeight.bold)),
// ),
// title: Text(this.workoutList[position].title,
// style: TextStyle(fontWeight: FontWeight.bold)),
// subtitle:
// Text('Daily reps ${this.workoutList[position].dailyReps}'),
// trailing: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text('Remaining reps'),
// Text('${this.workoutList[position].remainingReps}'),
// ],
// ),
// onTap: () {
// navigateToComplete(this.workoutList[position]);
// },
// ),


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
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Workout>> workoutListFuture = databaseHelper.getAllWorkouts();
      workoutListFuture.then((workoutList) {
        setState(() {
          this.workoutList = workoutList;
          this.count = workoutList.length;
        });
      });
    });
  }
}


