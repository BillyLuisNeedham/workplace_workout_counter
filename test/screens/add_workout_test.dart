import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/strings.dart';

void main() {
  group('AddWorkout', () {
    testWidgets('on click timer button, time per rep input is displayed',
        (WidgetTester tester) async {
      Workout testWorkout = new Workout();
      await tester.pumpWidget(MaterialApp(
          home: AddWorkout(
        workout: testWorkout,
      )));

      //tap timer button
      await tester
          .tap(find.byTooltip('Click to add timer functionality to workout'));

      await tester.pump();


      //find timer input and check it exists
      final finderTimer = find.widgetWithText(TextField, Strings.timer);
      expect(finderTimer, findsOneWidget);

      //TODO build widget out then continue tests once current one passes
      //tap timer button again

      //see find timer input gone
    });
  });
}
