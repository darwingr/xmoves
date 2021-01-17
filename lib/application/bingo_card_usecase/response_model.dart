class ActivitySummary {
  String category;
  int column;
  int row;
}

class BingoCardResponseModel {
  final String title;
  final List<ActivitySummary> _activities;

  BingoCardResponseModel(this.title) :
      _activities = <ActivitySummary>[];

  void addActivitySummary(ActivitySummary summary) {
    _activities.add(summary);
  }

  List<ActivitySummary> getActivitySummaries() => _activities;
}
