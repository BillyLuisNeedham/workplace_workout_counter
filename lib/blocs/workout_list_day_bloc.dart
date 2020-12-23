import 'package:rxdart/rxdart.dart';
import 'package:workplace_workout_counter/blocs/bloc.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/repositories/workout_repository.dart';

class WorkoutBloc implements Bloc {
  final _repository = WorkoutRepository();
  final _workoutFetcher = PublishSubject<List<Workout>>();
  
  Observable<List<Workout>> get allDayWorkouts => _workoutFetcher.stream;

  fetchAllDayWorkouts(String day) async {
    List<Workout> workoutList = await _repository.fetchAllDayWorkouts(day);
    _workoutFetcher.sink.add(workoutList);
  }

  @override
  void dispose() {
    _workoutFetcher.close();
  }
}

  final workoutBloc = WorkoutBloc();

