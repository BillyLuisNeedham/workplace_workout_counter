import 'dart:convert';

Workout clientFromMap(String str) => Workout.fromMap(json.decode(str));

String clientToMap(Workout data) => json.encode(data.toMap());

class Workout {
  Workout(
      {this.id,
      this.title,
      this.dailyReps,
      this.remainingReps,
      this.lastUpdated,
      this.day});

  int id;
  String title;
  String dailyReps;
  String remainingReps;
  String lastUpdated;
  String day;

  //prevent workouts being saved with null
  bool suitableToSave() {
    return this.title != null &&
        this.dailyReps != null &&
        this.remainingReps != null;
  }

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
      id: json["id"],
      title: json["title"],
      dailyReps: json["daily_reps"],
      remainingReps: json["remaining_reps"],
      lastUpdated: json["last_updated"],
      day: json["day"]);


  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "daily_reps": dailyReps,
        "remaining_reps": remainingReps,
        "last_updated": lastUpdated,
        "day": day,
      };
}
