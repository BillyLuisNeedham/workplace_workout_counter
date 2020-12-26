import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/screens/complete_workout.dart';
import 'package:workplace_workout_counter/strings.dart';

void main() {
  group('CompleteWorkout', () {
    testWidgets(
        'If workout is a timer workout start, stop and reset buttons are displayed',
        (WidgetTester tester) async {
      final String start = Strings.start;
      final String stop = Strings.stop;
      final String reset = Strings.reset;

      String now = DateFormat.yMMMd().format(DateTime.now());

      Workout testWorkout = new Workout(
        id: 1,
        title: 'test timer workout',
        dailyReps: '10',
        remainingReps: '10',
        lastUpdated: now,
        secondsPerRep: 60,
      );

      await tester.pumpWidget(MaterialApp(
          home: CompleteWorkout(
        workout: testWorkout,
        appBarTitle: 'test',
      )));

      //see start button
      final finderStart = find.widgetWithText(CompleteWorkoutButton, start);
      expect(finderStart, findsOneWidget);

      //see stop button
      final finderStop = find.widgetWithText(CompleteWorkoutButton, stop);
      expect(finderStop, findsOneWidget);

      //see reset button
      final finderReset = find.widgetWithText(CompleteWorkoutButton, reset);
      expect(finderReset, findsOneWidget);

      //TODO write code to get test to pass
    });
  });
}
