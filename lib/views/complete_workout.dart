import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/utils/database.dart';

class CompleteWorkoutButton extends StatelessWidget {
  final int reps;
  final ValueSetter<int> onPress;

  CompleteWorkoutButton({this.reps, this.onPress});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.grey,
      onPressed: () {
        onPress(reps);
      },
      child: Text(
        '- $reps',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class CompleteWorkoutButtonRow extends StatelessWidget {
  final ValueSetter<int> onPress;
  CompleteWorkoutButtonRow({this.onPress});

  @override
  Widget build(BuildContext context) {
    List<int> buttonValues = [1, 5, 10, 25, 50];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      children: [
        for (var item in buttonValues)
          CompleteWorkoutButton(
            reps: item,
            onPress: this.onPress,
          )
      ],
    );
  }
}

const _textStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 20.0,
);

class CompleteWorkout extends StatefulWidget {
  final Workout workout;
  final String appBarTitle;
  CompleteWorkout({this.workout, this.appBarTitle});

  @override
  _CompleteWorkoutState createState() =>
      _CompleteWorkoutState(this.workout, this.appBarTitle);
}

class _CompleteWorkoutState extends State<CompleteWorkout> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Workout workout;
  String appBarTitle;

  _CompleteWorkoutState(this.workout, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    double percentage =
        int.parse(workout.dailyReps) / int.parse(workout.remainingReps);

    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            appBarTitle,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                workout.title,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      workout.dailyReps,
                      style: _textStyle,
                    ),
                    CircularPercentIndicator(
                      radius: 90.0,
                      lineWidth: 8.0,
                      percent: 0.5,
                      backgroundColor: Colors.green[900],
                      progressColor: Colors.green[200],
                    ),
                    Text(
                      workout.remainingReps,
                      style: _textStyle,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              CompleteWorkoutButtonRow(
                onPress: _completeReps,
              ),
            ],
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //remove reps from remaining reps of workout
  void _completeReps(int reps) {
    int remainingReps = int.parse(workout.remainingReps) - reps;
    workout.remainingReps = remainingReps.toString();
    setState(() {});
  }

  //save updated workout to database
  void _save() async {
    workout.lastUpdated = DateFormat.yMMMd().format(DateTime.now());
    moveToLastScreen();

    int result;

    //update operation
    result = await databaseHelper.updateWorkout(workout);

    //show error if failure
    if (result == 0) {
      _showAlertDialog('Status', 'Problem Updating Workout');
    }
  }

  //TODO delete selected workout from database

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
