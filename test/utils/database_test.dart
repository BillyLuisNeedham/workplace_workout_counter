import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/utils/database.dart';

void main() {
  group('DatabaseHelper', () {
    test('Remaining reps reset if last updated date not today', () {
      final DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

      final String yesterdayFormatted = DateFormat.yMMMd().format(yesterday);

      final Workout yesterdayWorkout = Workout(
          id: 1,
          dailyReps: '10',
          remainingReps: '5',
          title: 'test workout',
          lastUpdated: yesterdayFormatted);

      final List<Workout> workoutList = [yesterdayWorkout];
      // TODO check that workout list is resetting date if not now

      DatabaseHelper dbHelper = DatabaseHelper();

      List<Workout> newWorkoutList =
          dbHelper.workoutListRemainingRepsHandler(workoutList);

      expect(newWorkoutList[0].remainingReps, '10');
    });
  });
}
