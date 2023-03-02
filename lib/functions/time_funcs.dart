class TimeFuncs {
  static String dateTimeToString(DateTime dateTime) {
    return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  static String dateTimeToTimeString(DateTime dateTime) {
    return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ";
  }

  static String dateTimeToDateString(DateTime dateTime) {
    bool isAm = true;
    int hour = dateTime.hour;
    if (hour > 11) {
      if (hour == 12) {
        isAm = false;
      } else {
        hour -= 12;
        isAm = false;
      }
    }

    return "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${isAm ? "AM" : "PM"}";
  }

  static DateTime stringToDateTime(String dateTimeString) {
    List<String> dateTimeParts = dateTimeString.split(" ");
    List<String> dateParts = dateTimeParts[0].split("-");
    List<String> timeParts = dateTimeParts[1].split(":");
    return DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
        int.parse(timeParts[2]));
  }
}
