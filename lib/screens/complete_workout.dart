import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:workplace_workout_counter/blocs/workout_bloc.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/repositories/workout_repository.dart';
import 'package:workplace_workout_counter/strings.dart';
import 'package:workplace_workout_counter/utils/util_functions.dart';

class CompleteWorkoutButton extends StatelessWidget {
  final int reps;
  final ValueSetter<int> onPress;

  CompleteWorkoutButton({Key key, this.reps, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: Key('${Strings.minusRepsButtonKey}_$reps'),
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
  CompleteWorkoutButtonRow({Key key, this.onPress}) : super(key: key);

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
  CompleteWorkout({Key key,this.workout, this.appBarTitle}) : super(key: key);

  @override
  _CompleteWorkoutState createState() =>
      _CompleteWorkoutState(this.workout, this.appBarTitle);
}

class _CompleteWorkoutState extends State<CompleteWorkout> {
  WorkoutBloc workoutBloc = WorkoutBloc(workoutRepository: WorkoutRepository());

  Workout workout;
  String appBarTitle;

  _CompleteWorkoutState(this.workout, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    final String initialRemainingRepsState = workout.dailyReps;
    double percentageComplete =
        int.parse(workout.remainingReps) / int.parse(workout.dailyReps);

    return WillPopScope(
      onWillPop: () {
        _onBackPressed(initialRemainingRepsState);
      },
      child: Scaffold(
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
                        key: Key(Strings.dailyWorkoutRepsKey),
                        style: _textStyle,
                      ),
                      CircularPercentIndicator(
                        radius: 90.0,
                        lineWidth: 8.0,
                        percent: percentageDisplayHandler(percentageComplete),
                        backgroundColor: Colors.green[900],
                        progressColor: Colors.green[200],
                      ),
                      Text(
                        workout.remainingReps,
                        key: Key(Strings.updateWorkoutToolTip),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Tooltip(
                      message: Strings.deleteWorkoutToolTip,
                      child: IconButton(
                        onPressed: () {
                          _delete();
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 60,
                        ),
                      ),
                    ),
                    Tooltip(
                      message: Strings.updateWorkoutToolTip,
                      child: IconButton(
                        onPressed: () {
                          _save();
                        },
                        icon: Icon(
                          Icons.add_circle,
                          size: 60,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //remove reps from remaining reps of workout
  void _completeReps(int reps) {
    setState(() {
      int remainingReps = int.parse(workout.remainingReps) - reps;
      workout.remainingReps = remainingReps.toString();
    });
  }

  //save updated workout to database
  void _save() async {
    workout.lastUpdated = DateFormat.yMMMd().format(DateTime.now());
    moveToLastScreen();

    int result;

    //update operation
    result = await workoutBloc.updateWorkout(workout);

    //show error if failure
    if (result == 0) {
      _showAlertDialog('Status', 'Problem Updating Workout');
    }
  }

  //delete workout from database
  void _delete() async {
    moveToLastScreen();

    int result;

    //delete operation
    result = await workoutBloc.deleteWorkout(workout.id);

    //show error if failure
    if (result == 0) {
      _showAlertDialog('Status', 'Problem Deleting Workout');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  // handle back navigation
  void _onBackPressed(String initialState) {
    //reset remainingReps
    workout.remainingReps = initialState;

    moveToLastScreen();
  }
}
