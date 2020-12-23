import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/screens/workout_list_day_screen.dart';

class DayList extends StatefulWidget {
  @override
  _DayListState createState() => _DayListState();
}

class _DayListState extends State<DayList> {
  @override
  Widget build(BuildContext context) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Workout Calender',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
        child: ListView.builder(
          itemCount: days.length,
          itemBuilder: (BuildContext context, int position) {
            return GestureDetector(
              onTap: () {
                navigateToWorkoutList(days[position]);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 48.0),
                child: Card(
                  color: Colors.white,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 0.0),
                    child: Center(
                      child: Text(
                        days[position],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }



  void navigateToWorkoutList(String day) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutListDayScreen(
        day: day,
      );
    }));
  }
}
