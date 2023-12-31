class TimeConvert {
  static String hoursMinutesFromMillisecondsSinceEpoch(
      int millisecondsSinceEpoch) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final String hourFormat = dateTime.hour.toString().padLeft(2, '0');
    final String minuteFormat = dateTime.minute.toString().padLeft(2, '0');
    return "$hourFormat:$minuteFormat ";
  }
}
