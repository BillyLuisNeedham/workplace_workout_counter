import 'package:flutter/material.dart';

class AddWorkout extends StatefulWidget {
  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
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
      body: Center(
        child: Text(
          'Add Workout Screen',
        ),
      ),
    );
  }
}