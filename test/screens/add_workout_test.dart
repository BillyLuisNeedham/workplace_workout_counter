import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workplace_workout_counter/blocs/workout_bloc.dart';
import 'package:workplace_workout_counter/custom_widgets/text_field_standard.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/repositories/workout_repository.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/strings.dart';
import 'package:workplace_workout_counter/utils/util_functions.dart';

class MockWorkoutRepository extends Mock implements WorkoutRepository {}

void main() {
  WorkoutBloc workoutBloc;
  MockWorkoutRepository workoutRepository;

  setUp(() {
    workoutRepository = MockWorkoutRepository();
    workoutBloc = WorkoutBloc(workoutRepository: workoutRepository);
        // WorkoutBloc(workoutRepository: workoutRepository);
  });

  tearDown(() {
    workoutBloc.workoutController.close();
  });

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
        'When timer inputs are entered, bloc is called with a workout that has correct amounts of seconds from entered minutes and seconds',
        (WidgetTester tester) async {
      final String testTitle = 'test title';
      final String now = getDateNow();
      final Workout expectedWorkout = Workout(
          title: testTitle,
          dailyReps: '10',
          remainingReps: '10',
          secondsPerRep: 122,
          lastUpdated: now);

      when(workoutRepository.saveWorkout(expectedWorkout))
          .thenAnswer((_) async => 1);

      Workout testWorkout = new Workout();

      AddWorkout addWorkout = new AddWorkout(
        workout: testWorkout,
      );

      await tester.pumpWidget(MaterialApp(home: addWorkout));

      //click timer button
      await tester.tap(find.byTooltip(Strings.timerButtonToolTip));

      //enter workout details
      await tester.enterText(
          find.widgetWithText(TextFieldBase, Strings.exercise), 'test title');
      await tester.enterText(
          find.widgetWithText(TextFieldBase, Strings.reps), '10');

      //enter timer 2 minutes and 2 seconds
      await tester.enterText(
          find.widgetWithText(TextField, Strings.minutesPerRep), '2');
      await tester.enterText(
          find.widgetWithText(TextField, Strings.secondsPerRep), '2');

      //click add
      await tester.tap(find.byTooltip(Strings.addButtonToolTip));

      //see that WorkoutBloc is called with a workout model that has correct data and 122 secondsPerRep
      verify(workoutRepository.saveWorkout(expectedWorkout)).called(1);
    });

    //TODO ensure when entering timer, if there is no time filled in shows error
    // TODO change timer tool tip between adding and removing
    // TODO change reps text input action from next to done when time on or off
  });
}
