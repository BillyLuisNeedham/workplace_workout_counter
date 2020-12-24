import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/dao/workout_dao.dart';
import 'package:workplace_workout_counter/models/workout.dart';

void main() {
  group('WorkoutDao', () {
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
      WorkoutDao workoutDao = WorkoutDao();

      List<Workout> newWorkoutList =
          workoutDao.workoutListRemainingRepsHandler(workoutList);

      expect(newWorkoutList[0].remainingReps, '10');
    });

    test(
        'If workout remaining reps is at 0 and the last updated date is not today, daily reps is increased by 5%',
        () {
      final DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      final String yesterdayFormatted = DateFormat.yMMMd().format(yesterday);

      final Workout completedWorkout = Workout(
          id: 1,
          dailyReps: '100',
          remainingReps: '0',
          title: 'test workout',
          lastUpdated: yesterdayFormatted);

      final List<Workout> workoutList = [completedWorkout];
      WorkoutDao workoutDao = WorkoutDao();

      List<Workout> newWorkoutList =
          workoutDao.workoutListRemainingRepsHandler(workoutList);

      expect(newWorkoutList[0].dailyReps, '105');
      expect(newWorkoutList[0].remainingReps, '105');
    });

    test('Auto increment function adds 5%', () {
      final DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      final String yesterdayFormatted = DateFormat.yMMMd().format(yesterday);

      final Workout completedWorkout = Workout(
          id: 1,
          dailyReps: '100',
          remainingReps: '0',
          title: 'test workout',
          lastUpdated: yesterdayFormatted);

      final expectedWorkout = Workout(
          id: 1,
          dailyReps: '105',
          remainingReps: '105',
          title: 'test workout',
          lastUpdated: yesterdayFormatted);

      WorkoutDao workoutDao = WorkoutDao();

      Workout result = workoutDao.workoutAutoIncrement(completedWorkout);

      expect(result.dailyReps, expectedWorkout.dailyReps);
    });
  });
}
