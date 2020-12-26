import 'package:test/test.dart';
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
  });
}
