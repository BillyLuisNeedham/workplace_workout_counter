import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: TextField(
              controller: titleController,
              style: textStyle,
              onChanged: (text) {
                updateTitle();
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: Strings.exercise),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              style: textStyle,
              onChanged: (text) {
                updateReps();
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: Strings.reps),
            ),
          ),
          timerWorkout ?
            Row(children: [
              Expanded(
                // TODO replace with a TextFieldStandard
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: TextField(
                    // TODO update controller: repsController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    style: textStyle,
                    onChanged: (text) {
                      updateReps();
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.minutesPerRep),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: TextField(
                    // TODO update controller: repsController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    style: textStyle,
                    onChanged: (text) {
                      updateReps();
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.secondsPerRep),
                  ),
                ),
              ),
            ]) : SizedBox(),
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
      _showAlertDialog('Status', 'Problem Saving Workout');
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
