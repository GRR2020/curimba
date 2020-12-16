enum TimeDefinitions { Week, Month }

extension TimeValues on TimeDefinitions {
  int get days {
    switch (this) {
      case TimeDefinitions.Week:
        return 7;
      case TimeDefinitions.Month:
        return 30;
      default:
        return 0;
    }
  }
}