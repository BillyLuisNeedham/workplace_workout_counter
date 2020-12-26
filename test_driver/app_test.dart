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
    final String workoutRepsSubtract5 = '53';
    final updateWorkoutFinder = find.byTooltip(Strings.updateWorkoutToolTip);
    final deleteWorkoutFinder = find.byTooltip(Strings.deleteWorkoutToolTip);
    final minusFiveRepsButtonFinder =
        find.byValueKey('${Strings.minusRepsButtonKey}_5');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(
        'can add a workout and it is displayed, can update the workout and then delete it',
        () async {
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

      //navigate to complete workouts
      await driver.tap(find.text(workoutTitle));

      //minus some reps
      await driver.tap(minusFiveRepsButtonFinder);

      //see daily reps and current reps (should be daily reps minus amount removed
      await driver.waitFor(find.text(workoutReps));
      await driver.waitFor(find.text(workoutRepsSubtract5));

      //update workout in database
      await driver.tap(updateWorkoutFinder);

      //see updated workout in list
      await driver.waitFor(find.text(workoutTitle));
      await driver.waitFor(find.text(workoutRepsSubtract5));

      //navigate to update workout list
      await driver.tap(find.text(workoutTitle));

      //delete workout
      await driver.tap(deleteWorkoutFinder);

      //see workout doesn't exist
      await driver.waitForAbsent(find.text(workoutTitle));
    });
  });
}
