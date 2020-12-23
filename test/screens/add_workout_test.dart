import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workplace_workout_counter/custom_widgets/text_field_standard.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/repositories/workout_repository.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/strings.dart';

class MockRepository extends Mock implements WorkoutRepository {}

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
      final finderMinutes =
          find.widgetWithText(TextField, Strings.minutesPerRep);
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
      final finderSeconds =
          find.widgetWithText(TextField, Strings.secondsPerRep);
      expect(finderSeconds, findsOneWidget);

      //tap timer button again
      await tester.tap(find.byTooltip(Strings.timerButtonToolTip));

      await tester.pump();

      //find no seconds timer input
      expect(finderSeconds, findsNothing);
    });

    testWidgets(
        'if the text inputs are empty the add button is clicked, a warning is displayed',
        (WidgetTester tester) async {
      Workout testWorkout = new Workout();
      await tester
          .pumpWidget(MaterialApp(home: AddWorkout(workout: testWorkout)));

      //tap add button
      await tester.tap(find.byTooltip(Strings.addButtonToolTip));

      await tester.pump();

      //warning is displayed
      final finderWarning =
          find.widgetWithText(AlertDialog, Strings.addWorkoutError);
      expect(finderWarning, findsOneWidget);
    });

    testWidgets(
        'when reps and name input are filled and add button is clicked, the workout with the correct data is saved',
        (WidgetTester tester) async {
      final repository = MockRepository();
      final String workoutTitle = 'test workout';
      final String workoutReps = '28';

      Workout testWorkout = new Workout();

      await tester.pumpWidget(MaterialApp(
        home: AddWorkout(
          workout: testWorkout,
        ),
      ));

      final finderExercise =
          find.widgetWithText(TextFieldBase, Strings.exercise);

      await tester.enterText(finderExercise, workoutTitle);

      final finderReps = find.widgetWithText(TextFieldBase, Strings.reps);

      await tester.enterText(finderReps, workoutReps);

      await tester.pump();

      await tester.tap(find.byTooltip(Strings.addButtonToolTip));

      await tester.pump();

      // TODO test that repository.saveWorkout is called with correct params
      verify(repository.saveWorkout(
          Workout(title: workoutTitle, dailyReps: '28', remainingReps: '28')));
    });

    // TODO change timer tool tip between adding and removing
    // TODO change reps text input action from next to done when time on or off
  });
}
