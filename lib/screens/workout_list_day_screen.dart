import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/custom_widgets/workout_list/workout_list_day.dart';
import 'package:workplace_workout_counter/strings.dart';
import 'package:workplace_workout_counter/models/workout.dart';
import 'package:workplace_workout_counter/screens/add_workout.dart';
import 'package:workplace_workout_counter/screens/complete_workout.dart';

class WorkoutListDayScreen extends StatefulWidget {

  final String day;

  WorkoutListDayScreen({this.day});

  @override
  _WorkoutListDayScreenState createState() => _WorkoutListDayScreenState(this.day);
}

class _WorkoutListDayScreenState extends State<WorkoutListDayScreen> {
  int count = 0;

  final String day;
  _WorkoutListDayScreenState(this.day);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          this.day,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: WorkoutListDay(day: this.day, onClickWorkoutTileCallback: navigateToComplete,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAdd(Workout(day: this.day));
        },
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add, size: 50, color: Colors.amber[200]),
      ),
    );
  }

  void navigateToAdd(Workout workout) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddWorkout(workout: workout);
    }));

    if (result == true) {
      setState(() {});
    }
  }

  void navigateToComplete(Workout workout) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CompleteWorkout(workout: workout, appBarTitle: workout.title);
    }));

    if (result == true) {
      setState(() {});
    }
  }

}

