import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/blocs/workout_bloc.dart';
import 'package:workplace_workout_counter/custom_widgets/text_field_standard.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/utils/util_functions.dart';

import '../strings.dart';

class AddWorkout extends StatefulWidget {
  final Workout workout;
  final WorkoutBloc workoutBloc;

  AddWorkout({Key key, @required this.workout, @required this.workoutBloc})
      : super(key: key);

  @override
  _AddWorkoutState createState() {
    return _AddWorkoutState(
        workout: this.workout, workoutBloc: this.workoutBloc);
  }
}

class _AddWorkoutState extends State<AddWorkout> {
  WorkoutBloc workoutBloc;

  Workout workout;

  TextEditingController titleController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondsController = TextEditingController();

  _AddWorkoutState({this.workout, this.workoutBloc});

  bool timerWorkout = false;

  @override
  Widget build(BuildContext context) {
    titleController.text = workout.title;
    repsController.text = workout.dailyReps;

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          Strings.addWorkouts,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                Strings.addWorkout,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ]),
          ),
          Tooltip(
            message: Strings.inputExerciseTitleToolTip,
            child: TextFieldBase(
              controller: titleController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              labelText: Strings.exercise,
              onChangedCallback: updateTitle,
            ),
          ),
          Tooltip(
            message: Strings.inputRepsToolTip,
            child: TextFieldBase(
              controller: repsController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              labelText: Strings.reps,
              onChangedCallback: updateReps,
            ),
          ),
          timerWorkout
              ? Row(children: [
                  Expanded(
                    child: TextFieldBase(
                      onChangedCallback: updateSecondsPerRep,
                      controller: minutesController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      labelText: Strings.minutesPerRep,
                    ),
                  ),
                  Expanded(
                      child: TextFieldBase(
                    onChangedCallback: updateSecondsPerRep,
                    controller: secondsController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    labelText: Strings.secondsPerRep,
                  )),
                ])
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Tooltip(
                  message: Strings.timerButtonToolTip,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        timerWorkout = !timerWorkout;
                        workout.secondsPerRep = null;
                      });
                    },
                    color: Colors.deepPurple[900],
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        Strings.timer,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Tooltip(
                  message: Strings.addButtonToolTip,
                  child: FlatButton(
                    onPressed: () async {
                      setState(() {
                        workout.suitableToSave()
                            ? _save()
                            : _showAlertDialog(
                                Strings.warning, Strings.addWorkoutError);
                      });
                    },
                    color: Colors.deepPurple[900],
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        Strings.add,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //update the title of the workout
  void updateTitle() {
    workout.title = titleController.text;
  }

  //update dailyReps of the workout
  void updateReps() {
    workout.dailyReps = repsController.text;
    workout.remainingReps = repsController.text;
  }

  //update secondsPerRep of the workout
  void updateSecondsPerRep() {
    int minutes =
        minutesController.text.isNotEmpty ? minutesController.text.toInt() : 0;
    int seconds =
        secondsController.text.isNotEmpty ? secondsController.text.toInt() : 0;

    workout.secondsPerRep = toSecondsHandler(minutes, seconds);
  }

  //save workout two database
  void _save() async {
    workout.lastUpdated = getDateNow();
    print('saved workout ${workout.toMap()}');
    moveToLastScreen();

    int result;
    //insert operation
    result = await workoutBloc.addWorkout(workout);

    if (result == 0) {
      //failure
      _showAlertDialog(Strings.status, Strings.problemSavingWork);
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
