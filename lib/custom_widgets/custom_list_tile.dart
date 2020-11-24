import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/models/workout.dart';

const _rowHeight = 30.0;
const _borderRadius = BorderRadius.all(Radius.circular(10));

class CustomListTile extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  CustomListTile({this.workout, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: Colors.red[50],
          splashColor: Colors.red[100],
          onTap: () {
            print('I was tapped');
            this.onTap();
          },
          child: Column(
            children: [
              Row(
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

            ],
          ),
        ),
      ),
    );
  }
}
