import 'package:intl/intl.dart';

class DateUtility {
  static const List<String> shortMonthLabel = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  // Get one year before referenceDate.
  static DateTime oneYearBefore(final DateTime referenceDate) {
    return DateTime(
      referenceDate.year - 1,
      referenceDate.month,
      referenceDate.day,
    );
  }

  // Change day of referenceDate.
  static DateTime changeDay(final DateTime referenceDate, final int dayCount) {
    return DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day + dayCount,
    );
  }

  // Calculate difference in days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    final localFrom = from.toLocal();
    final localTo = to.toLocal();
    final fromFormatted =
        DateTime(localFrom.year, localFrom.month, localFrom.day);
    final toFormatted = DateTime(localTo.year, localTo.month, localTo.day);
    return (toFormatted.difference(fromFormatted).inHours / 24).round();
  }

  static DateTime mostRecentMonday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day - (now.weekday - 1));
  }

  static DateTime nextSunday() {
    final now = DateTime.now();
    return now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  }

  static String formatTheCurrentWeek() {
    final recentMonday = DateUtility.mostRecentMonday();
    final nextSunday = DateUtility.nextSunday();
    final formatMonthDay =
        DateFormat(DateFormat.ABBR_MONTH_DAY).format(recentMonday);
    final formatNextSunday = DateFormat(DateFormat.DAY).format(nextSunday);
    return '$formatMonthDay - $formatNextSunday';
  }

  static String formatSecondsToMinutesAndSeconds(int seconds) {
    String parseTime(String time) {
      if (time.length <= 1) return '0$time';
      return time;
    }

    final min = seconds ~/ 60;
    final sec = seconds % 60;

    final parsedTime =
        '${parseTime(min.toString())} : ${parseTime(sec.toString())}';

    return parsedTime;
  }
}
