import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/views/add_workout.dart';
import 'package:workplace_workout_counter/views/complete_workout.dart';
import 'package:workplace_workout_counter/views/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/add': (context) => AddWorkout(),
    '/complete': (context) => CompleteWorkout(),
  },
));


