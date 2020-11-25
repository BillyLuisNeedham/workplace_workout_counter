import 'package:flutter/material.dart';

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
        body: ListView.builder(
          itemCount: days.length,
          itemBuilder: (BuildContext context, int position) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                child: Text(
                  days[position],
                  style: TextStyle(),
                ),
              ),
            );
          },
        ));
  }
}
