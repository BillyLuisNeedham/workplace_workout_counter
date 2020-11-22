import 'dart:convert';

Workout clientFromMap(String str) => Workout.fromMap(json.decode(str));

String clientToMap(Workout data) => json.encode(data.toMap());

class Workout {
  Workout({
    this.id,
    this.title,
    this.dailyReps,
    this.remainingReps
  });

  int id;
  String title;
  int dailyReps;
  int remainingReps;

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
    id: json["id"],
    title: json["title"],
    dailyReps: json["daily_reps"],
    remainingReps: json["remaining_reps"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "daily_reps": dailyReps,
    "remaining_reps": remainingReps,
  };
}
