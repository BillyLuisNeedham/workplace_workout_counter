import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:workplace_workout_counter/models/workout.dart';

const _borderRadius = BorderRadius.all(Radius.circular(10));

class CustomListTile extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;
  CustomListTile({this.workout, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width - 100;
    final double percentage = int.parse(workout.dailyReps) / int.parse(workout.remainingReps);


    return Material(
      color: Colors.transparent,
      child: Container(
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: Colors.red[50],
          splashColor: Colors.red[100],
          onTap: () {
            print('I was tapped');
            this.onTap();
          },
          child: SizedBox(
            width: _width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workout.title,
                      ),
                      Text(
                        workout.remainingReps,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        width: _width,
                        lineHeight: 12.0,
                        percent: percentage,
                        backgroundColor: Colors.grey[300],
                        progressColor: Colors.grey[500],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
