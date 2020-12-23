import 'package:workplace_workout_counter/dao/workout_dao.dart';
import 'package:workplace_workout_counter/models/workout.dart';

class WorkoutRepository {
  final workoutDao = WorkoutDao();

  //get all workouts
  Future getAllWorkouts() => workoutDao.getAllWorkouts();

  //get all day workouts
  Future fetchAllDayWorkouts(String day) => workoutDao.getAllDayWorkouts(day);

  //insert a workout into database
  Future saveWorkout(Workout newWorkout) => workoutDao.newWorkout(newWorkout);

  //fetch a workout from the database
  Future getWorkout(int id) => workoutDao.getWorkout(id);

  //update workout and save it to database
  Future updateWorkout(Workout newWorkout) => workoutDao.updateWorkout(newWorkout);

  //delete workout in database
  Future deleteWorkout(int id) => workoutDao.deleteWorkout(id);

  //delete all workouts in database
  Future deleteAllWorkouts() => workoutDao.deleteAllWorkouts();

}