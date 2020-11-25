// prevents displaying numbers outside of 0.0 - 1.0
double percentageDisplayHandler(double percentage) {
  double newPercentage = percentage;

  if (percentage > 1.0) {
    newPercentage = 1.0;
  }
  if (percentage < 0.0) {
    newPercentage = 0.0;
  }

  return newPercentage;
}
