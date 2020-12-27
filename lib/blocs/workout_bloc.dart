import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/blocs/bloc.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/repositories/workout_repository.dart';

class WorkoutBloc implements Bloc {
  final WorkoutRepository workoutRepository;
  // WorkoutRepository();
  final workoutController = StreamController<List<Workout>>.broadcast();
  String selectedDay;
  WorkoutBloc({@required this.workoutRepository});

  get allDayWorkouts => workoutController.stream;

  getAllDayWorkouts(String day) async {
    selectedDay = day;
    List<Workout> workoutList = await workoutRepository.fetchAllDayWorkouts(day);
    workoutController.sink.add(workoutList);
  }

  addWorkout(Workout newWorkout) async {
    await workoutRepository.saveWorkout(newWorkout);
    if (selectedDay != null) getAllDayWorkouts(selectedDay);
  }

  deleteWorkout(int id) async {
    await workoutRepository.deleteWorkout(id);
    if (selectedDay != null) getAllDayWorkouts(selectedDay);
  }

  updateWorkout(Workout newWorkout) async {
    await workoutRepository.updateWorkout(newWorkout);
    if (selectedDay != null) getAllDayWorkouts(selectedDay);
  }

  @override
  void dispose() {
    workoutController.close();
  }
}


