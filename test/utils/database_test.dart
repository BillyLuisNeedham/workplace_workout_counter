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
      DatabaseHelper dbHelper = DatabaseHelper();

      List<Workout> newWorkoutList =
          dbHelper.workoutListRemainingRepsHandler(workoutList);

      expect(newWorkoutList[0].remainingReps, '10');
    });

    test(
        'If workout remaining reps is at 0 and the last updated date is not today, daily reps is increased by 5%',
        () {
      final DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      final String yesterdayFormatted = DateFormat.yMMMd().format(yesterday);

      final Workout completedWorkout = Workout(
        id:1,
        dailyReps: '100',
        remainingReps: '0',
        title: 'test workout',
        lastUpdated: yesterdayFormatted
      );

      final List<Workout> workoutList = [completedWorkout];
      DatabaseHelper dbHelper = DatabaseHelper();

      List<Workout> newWorkoutList = dbHelper.workoutListRemainingRepsHandler(workoutList);

      expect(newWorkoutList[0].dailyReps, '105');
      expect(newWorkoutList[0].remainingReps, '105');
    });
  });
}
