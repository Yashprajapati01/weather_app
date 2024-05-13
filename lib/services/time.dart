import 'package:intl/intl.dart';

String getCurrentTime() {
  DateTime now = DateTime.now();
  return DateFormat('h:mm a').format(now); // 12-hour format without seconds
}

String getCurrentWeekday() {
  DateTime now = DateTime.now();
  return '${_getWeekdayName(now.weekday)}';
}

String _getWeekdayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Monday';
    case DateTime.tuesday:
      return 'Tuesday';
    case DateTime.wednesday:
      return 'Wednesday';
    case DateTime.thursday:
      return 'Thursday';
    case DateTime.friday:
      return 'Friday';
    case DateTime.saturday:
      return 'Saturday';
    case DateTime.sunday:
      return 'Sunday';
    default:
      return '';
  }
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return '${now.day}';// Display only day
}

String getgreeting(){
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 0 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}