import 'package:flutter/material.dart';
import 'package:workplace_workout_counter/Database.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Workouts',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('HomeScreen'),
          RaisedButton(
            onPressed: () async {
              final allWorkouts = await DBProvider.db.getAllWorkouts();
              print('query for all workouts:');
              allWorkouts.forEach((workout) => print(workout));
            },
            child: Text('workouts'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add, size: 50, color: Colors.amber[200]),
      ),
    );
  }
}

// FutureBuilder<List<Workout>>(
// future: DBProvider.db.getAllWorkouts(),
// builder: (BuildContext context, AsyncSnapshot<List<Workout>> snapshot) {
// if (snapshot.hasData) {
// return ListView.builder(
// itemCount: snapshot.data.length,
// itemBuilder: (BuildContext context, int index) {
// Workout item = snapshot.data[index];
// return ListTile(
// title: Text(item.title),
// leading: Text(item.dailyReps.toString()),
// trailing: Text(item.remainingReps.toString()),
// );
// },
// );
// } else {
// return Center(child: CircularProgressIndicator());
// }
// },
// ),