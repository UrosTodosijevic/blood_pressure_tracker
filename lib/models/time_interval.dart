enum TimeInterval {
  today,
  yesterday,
  week,
  month,
  forever,
}

// ignore: missing_return
String timeIntervalInStringFormat(TimeInterval timeInterval) {
  switch (timeInterval) {
    case TimeInterval.today:
      return 'Today';
    case TimeInterval.yesterday:
      return 'Yesterday';
    case TimeInterval.week:
      return 'This Week';
    case TimeInterval.month:
      return 'This Month';
    case TimeInterval.forever:
      return 'Forever';
  }
}
