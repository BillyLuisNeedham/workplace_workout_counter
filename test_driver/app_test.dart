import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:workplace_workout_counter/strings.dart';

void main() {
  group('Workout Counter App', () {
    final fabFinder = find.byValueKey(Strings.fabAddWorkoutKey);
    final exerciseFinder = find.byTooltip(Strings.inputExerciseTitleToolTip);
    final repsFinder = find.byTooltip(Strings.inputRepsToolTip);
    final addButton = find.byTooltip(Strings.addButtonToolTip);
    final String workoutTitle = 'test workout';
    final String workoutReps = '58';
    final workoutFinder = find.text(workoutTitle);

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('can add a workout and it is displayed', () async {
      //navigate to add workout screen
      await driver.tap(fabFinder);

      //enter title and reps
      await driver.tap(exerciseFinder);
      await driver.enterText(workoutTitle);
      await driver.tap(repsFinder);
      await driver.enterText(workoutReps);

      //click add button
      await driver.tap(addButton);

      //see new workout in workout list
      await driver.waitFor(find.text(workoutTitle));
      await driver.waitFor(find.text(workoutReps));
    });
  });
  // TODO test deleting a workoutList
  // TODO test completing some reps on a workout
}
