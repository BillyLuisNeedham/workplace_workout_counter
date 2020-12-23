import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/custom_widgets/text_field_standard.dart';
import 'package:workplace_workout_counter/utils/database.dart';
import 'package:workplace_workout_counter/models/workout.dart';

import '../strings.dart';

class AddWorkout extends StatefulWidget {
  final Workout workout;

  AddWorkout({this.workout});

  @override
  _AddWorkoutState createState() {
    return _AddWorkoutState(this.workout);
  }
}

class _AddWorkoutState extends State<AddWorkout> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Workout workout;

  TextEditingController titleController = TextEditingController();
  TextEditingController repsController = TextEditingController();

  _AddWorkoutState(this.workout);

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
          TextFieldBase(
            controller: titleController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            labelText: Strings.exercise,
            onChangedCallback: updateTitle,
          ),
          TextFieldBase(
            controller: repsController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            labelText: Strings.reps,
            onChangedCallback: updateReps,
          ),
          timerWorkout
              ? Row(children: [
                  Expanded(
                    child: TextFieldBase(
                      // TODO add controller
                      // TODO add callback
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      labelText: Strings.minutesPerRep,
                      // TODO tidy up
                    ),
                  ),
                  Expanded(
                      child: TextFieldBase(
                    // TODO Add controller
                    // TODO Add callback
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    labelText: Strings.secondsPerRep,
                  )
                      ),
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

  //save workout to database
  void _save() async {
    workout.lastUpdated = DateFormat.yMMMd().format(DateTime.now());
    moveToLastScreen();

    int result;
    //insert operation
    result = await databaseHelper.newWorkout(workout);

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
