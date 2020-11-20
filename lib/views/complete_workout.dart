import 'package:flutter/material.dart';

class CompleteWorkout extends StatefulWidget {
  @override
  _CompleteWorkoutState createState() => _CompleteWorkoutState();
}

class _CompleteWorkoutState extends State<CompleteWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Complete Workout',
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
}
