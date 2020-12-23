import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/blocs/workout_list_day_bloc.dart';
import 'package:workplace_workout_counter/custom_widgets/workout_list/workout_list_tile.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class WorkoutListDay extends StatelessWidget {
  final String day;
  final void Function(Workout) onClickWorkoutTileCallback;

  WorkoutListDay({this.day, this.onClickWorkoutTileCallback});

  @override
  Widget build(BuildContext context) {
   workoutBloc.fetchAllDayWorkouts(day);
    return StreamBuilder(
        stream: workoutBloc.allDayWorkouts,
        builder: (context,
        AsyncSnapshot<List<Workout>> snapshot) {
          if (snapshot.hasData) {
            return workoutList(snapshot, this.onClickWorkoutTileCallback);
            } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child:
            CircularProgressIndicator());
        }
      );
  }

  // TODO rip into own component
  Widget workoutList(AsyncSnapshot<List<Workout>> snapshot, final void Function(Workout) onClickTileCallback) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int position) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
        child: Card(
            color: Colors.white,
            elevation: 4.0,
            child: WorkoutListTile(
              workout: snapshot.data[position],
              onTap: () {
                onClickWorkoutTileCallback(snapshot.data[position]);
              },
            )),
      );
    });
  }
}
