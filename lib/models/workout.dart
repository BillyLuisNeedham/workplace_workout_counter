class Workout {
  final int id;
  final String title;
  final int dailyReps;
  final int remainingReps;
  final DateTime lastUpdated;

  Workout(
      {this.id,
      this.title,
      this.dailyReps,
      this.remainingReps,
      this.lastUpdated});
}
