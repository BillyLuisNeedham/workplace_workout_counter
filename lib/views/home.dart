import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/Database.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/views/add_workout.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: getWorkoutListView(),
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
    print('workoutlist $workoutList');
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(this.workoutList[position].title),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.workoutList[position].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text('Daily reps ${this.workoutList[position].dailyReps}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Remaining reps'),
                Text('${this.workoutList[position].remainingReps}'),
              ],
            ),
            onTap: () {
              debugPrint('ListTile tapped');
            },
          ),
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

  void getList() async {
    List<Workout> workouts = await databaseHelper.getAllWorkouts();
    print('workout list $workouts');
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
