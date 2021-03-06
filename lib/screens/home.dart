import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workplace_workout_counter/screens/day_list.dart';
import 'package:workplace_workout_counter/screens/workout_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String today = DateFormat('EEEE').format(DateTime.now());
  int _currentIndex = 0;
  final List<Widget> _children = [
    WorkoutList(day: today),
    DayList()
  ];
  @override
  Widget build(BuildContext context) {
  print('today : $today');
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTabbed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Today"
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            label: "Days"
          )
        ],
      ),
    );
  }

  void onTabTabbed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
