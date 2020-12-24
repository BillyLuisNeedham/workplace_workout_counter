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
  });
}