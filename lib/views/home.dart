import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workplace_workout_counter/Database.dart';
import 'package:workplace_workout_counter/models/workout.dart';

// Workouts not displaying. look at https://medium.com/@abeythilakeudara3/to-do-list-in-flutter-with-sqlite-as-local-database-8b26ba2b060e for ref

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBProvider databaseProvider = DBProvider();
  List<Workout> workoutList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (workoutList == null) {
      workoutList = List<Workout>();
      updateListView();
    }

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Workouts',
        ),
        centerTitle: true,
      ),
      body: getWorkoutListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add, size: 50, color: Colors.amber[200]),
      ),
    );
  }


  ListView getWorkoutListView() {
    print('workoutlist $workoutList');
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(
                  this.workoutList[position].title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.workoutList[position].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Daily reps ${this.workoutList[position].dailyReps}'),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Remaining reps'),
                Text('${this.workoutList[position].remainingReps}'),
              ],
            ),
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }
  
  void updateListView() {
    final Future<Database> dbFuture = databaseProvider.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Workout>> workoutListFuture = databaseProvider.getAllWorkouts();
      workoutListFuture.then((workoutList) {
        setState(() {
          this.workoutList = workoutList;
          this.count = workoutList.length;
        });
      });
    });
  }


}