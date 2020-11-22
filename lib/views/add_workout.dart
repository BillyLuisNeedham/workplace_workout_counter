import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/Database.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class AddWorkout extends StatefulWidget {
  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  String _exerciseName;
  String _dailyReps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Add Workouts',
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Add Workout',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: TextField(
              onChanged: (text) {
                _exerciseName = text;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Exercise'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                _dailyReps = text;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Reps'),
            ),
          ),
          FlatButton(
            onPressed: () async {
              int reps = int.parse(_dailyReps);
              addWorkout(_exerciseName, reps);
              Navigator.pop(context);
            },
            color: Colors.deepPurple[900],
            child: Text(
              'ADD',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

void addWorkout(String workoutName, int workoutReps) async {
  Workout instance = Workout(
      title: workoutName, dailyReps: workoutReps, remainingReps: workoutReps);
  await DBProvider.db.newWorkout(instance);
}
