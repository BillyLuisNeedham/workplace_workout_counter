import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/utils/database.dart';

class WorkoutRepository {
  final dbHelper = DatabaseHelper();

  Future<List<Workout>> fetchAllDayWorkouts(String day) => dbHelper.getAllDayWorkouts(day);

}