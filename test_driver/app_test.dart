import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Workout Counter App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });
    // todo check out https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
    // TODO test adding a workout
    // TODO test deleting a workoutList
    // TODO test completing some reps on a workout
  });
}
