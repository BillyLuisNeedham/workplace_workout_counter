// prevents displaying numbers outside of 0.0 - 1.0
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/models/time.dart';

double percentageDisplayHandler(double percentage) {
  double newPercentage = percentage;

  if (percentage > 1.0) {
    newPercentage = 1.0;
  }
  if (percentage < 0.0) {
    newPercentage = 0.0;
  }

  return newPercentage;
}

//convert String to int
extension NumberParser on String {
  int toInt() {
    return int.parse(this);
  }
}

//converts minutes and seconds to just seconds
int toSecondsHandler(int minutes, int seconds) {
  int minutesToSeconds = minutes * 60;
  return minutesToSeconds + seconds;
}

//converts seconds to a time model
Time toTimeModelHandler(int seconds) {
  int minutes = seconds ~/ 60;
  int remSeconds = seconds % 60;
  return Time(minutes: minutes, seconds: remSeconds);
}

//gets the current date
String getDateNow() {
  return DateFormat.yMMMd().format(DateTime.now());
}