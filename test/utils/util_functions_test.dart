import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:workplace_workout_counter/models/time.dart';
import 'package:workplace_workout_counter/utils/util_functions.dart';

void main() {
  group('Util functions', () {
    test('toInt parses a string to an int', () {
      //string number
      String stringNumber = '2';

      //call to int on string number
      int parsedString = stringNumber.toInt();

      //see string number now an int
      expect(parsedString, 2);
    });

    test('toSecondsHandler converts minutes and seconds to just seconds', () {
      //2 minutes and 1 seconds converts to 121 seconds
      final result = toSecondsHandler(2, 1);
      expect(result, 121);

      //0 minutes and 10 seconds converts to 10 seconds
      final result2 = toSecondsHandler(0, 10);
      expect(result2, 10);
    });

    test('toTimeModelHandler converts seconds to a time model', () {
      //121 seconds converts to a time model with 2 minutes and 1 second
      final Time expectedResult = Time(minutes: 2, seconds: 1);
      final result = toTimeModelHandler(121);
      expect(result.minutes, expectedResult.minutes);
      expect(result.seconds, expectedResult.seconds);

      //45 seconds converts to a time model of 0 minutes and 45 seconds
      final Time expectedResult2 = Time(minutes: 0, seconds: 45);
      final result2 = toTimeModelHandler(45);
      expect(result2.minutes, expectedResult2.minutes);
      expect(result2.seconds, expectedResult2.seconds);

      //60 seconds converts to a time model of 1 minutes and 0 seconds
      final Time expectedResult3 = Time(minutes: 1, seconds: 0);
      final result3 = toTimeModelHandler(60);
      expect(result3.minutes, expectedResult3.minutes);
      expect(result3.seconds, expectedResult3.seconds);
    });

    test('getDateNow gets the current date', () {
      final result = getDateNow();
      final now = DateFormat.yMMMd().format(DateTime.now());
      expect(result, now);
    });
  });
}
