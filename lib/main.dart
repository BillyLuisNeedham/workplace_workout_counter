import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/views/add_workout.dart';
import 'package:workplace_workout_counter/views/complete_workout.dart';
import 'package:workplace_workout_counter/views/day_list.dart';
import 'package:workplace_workout_counter/views/workout_list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => DayList(),
      '/list': (context) => WorkoutList(),
      '/add': (context) => AddWorkout(),
      '/complete': (context) => CompleteWorkout(),
    },
  ));
}


