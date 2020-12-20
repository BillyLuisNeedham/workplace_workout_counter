import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/strings.dart';

void main() {
  group('AddWorkout', () {
    testWidgets(
        'on click timer button, minute time per rep input is displayed, which is cleared when timer button is clicked again',
        (WidgetTester tester) async {
      Workout testWorkout = new Workout();
      await tester.pumpWidget(MaterialApp(
          home: AddWorkout(
        workout: testWorkout,
      )));

      //tap timer button
      await tester.tap(find.byTooltip(Strings.timerButtonToolTip));

      await tester.pump();

      //find minutes input and check it exists
      final finderMinutes = find.widgetWithText(TextField, Strings.minutesPerRep);
      expect(finderMinutes, findsOneWidget);

      // tap timer button again
      await tester.tap(find.byTooltip(Strings.timerButtonToolTip));

      await tester.pump();

      //find no minutes timer input
      expect(finderMinutes, findsNothing);
    });

    testWidgets(
        'on click timer button, seconds per rep input is displayed, which is cleared when timer button is clicked again',
        (WidgetTester tester) async {
      Workout testWorkout = new Workout();
      await tester
          .pumpWidget(MaterialApp(home: AddWorkout(workout: testWorkout)));

      //tap timer button
      await tester.tap(find.byTooltip(Strings.timerButtonToolTip));

      await tester.pump();

      //find seconds input and check exists
      final finderSeconds = find.widgetWithText(TextField, Strings.secondsPerRep);
      expect(finderSeconds, findsOneWidget);

      //tap timer button again
      await tester.tap(find.byTooltip(Strings.timerButtonToolTip));

      await tester.pump();

      //find no seconds timer input
          expect(finderSeconds, findsNothing);
    });

    // TODO change timer tool tip between adding and removing

  });
}
