import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/screens/complete_workout.dart';
import 'package:workplace_workout_counter/screens/day_list.dart';
import 'package:workplace_workout_counter/screens/workout_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
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


