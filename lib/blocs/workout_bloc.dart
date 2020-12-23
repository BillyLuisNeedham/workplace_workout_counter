import 'dart:async';

import 'package:workplace_workout_counter/blocs/bloc.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/repositories/workout_repository.dart';

class WorkoutBloc implements Bloc {
  final _workoutRepository = WorkoutRepository();
  final _workoutController = StreamController<List<Workout>>.broadcast();
  String selectedDay;

  get allDayWorkouts => _workoutController.stream;

  getAllDayWorkouts(String day) async {
    selectedDay = day;
    List<Workout> workoutList = await _workoutRepository.fetchAllDayWorkouts(day);
    _workoutController.sink.add(workoutList);
  }

  addWorkout(Workout newWorkout) async {
    await _workoutRepository.saveWorkout(newWorkout);
    if (selectedDay != null) getAllDayWorkouts(selectedDay);
  }

  deleteWorkout(int id) async {
    await _workoutRepository.deleteWorkout(id);
    if (selectedDay != null) getAllDayWorkouts(selectedDay);
  }

  updateWorkout(Workout newWorkout) async {
    await _workoutRepository.updateWorkout(newWorkout);
    if (selectedDay != null) getAllDayWorkouts(selectedDay);
  }

  @override
  void dispose() {
    _workoutController.close();
  }
}

  final workoutBloc = WorkoutBloc();

