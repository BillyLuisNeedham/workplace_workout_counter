import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/utils/database.dart';

class CompleteWorkout extends StatefulWidget {
  final Workout workout;
  final String appBarTitle;
  CompleteWorkout({this.workout, this.appBarTitle});

  @override
  _CompleteWorkoutState createState() =>
      _CompleteWorkoutState(this.workout, this.appBarTitle);
}

class _CompleteWorkoutState extends State<CompleteWorkout> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Workout workout;
  String appBarTitle;

  _CompleteWorkoutState(this.workout, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          appBarTitle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Complete Workout',
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //remove reps from remaining reps of workout
  void _completeReps(int reps) {
    int remainingReps = int.parse(workout.remainingReps) - reps;
    workout.remainingReps = remainingReps.toString();
  }

  //save updated workout to database
  void _save() async {
    workout.lastUpdated = DateFormat.yMMMd().format(DateTime.now());
    moveToLastScreen();

    int result;

    //update operation
    result = await databaseHelper.updateWorkout(workout);

    //show error if failure
    if (result == 0) {
      _showAlertDialog('Status', 'Problem Updating Workout');
    }
  }

  //TODO delete selected workout from database

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
