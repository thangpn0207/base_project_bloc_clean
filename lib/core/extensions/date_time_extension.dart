import 'dart:core';

extension DateTimeExtension on DateTime {
  //get first day of this week
  DateTime get firstDayOfWeek => subtract(Duration(days: weekday - 1));

  //get last day of this week
  DateTime get lastDayOfWeek =>
      add(Duration(days: DateTime.daysPerWeek - weekday));

  //get previous day
  DateTime get previousDay => DateTime(year, month, day - 1);

  //get next day
  DateTime get nextDay => DateTime(year, month, day + 1);

  //get previous month
  DateTime get previousMonth => DateTime(year, month - 1, day);

  //get next month
  DateTime get nextMonth => DateTime(year, month + 1, day);

  //get next 2 month
  DateTime get next2Month => DateTime(year, month + 2, day);

  //get next 3 month
  DateTime get next3Month => DateTime(year, month + 3, day);

  //get day at 25
  DateTime get day25 => DateTime(year, month, 25);

  //get day at 24
  DateTime get day24 => DateTime(year, month, 24);

  //get last day of this month
  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  //get last day of next month
  DateTime get lastDayOfNextMonth => DateTime(year, month + 2, 0);

  //get last day of next 2 month
  DateTime get lastDayOfNext2Month => DateTime(year, month + 3, 0);

  //get last day of next 3 month
  DateTime get lastDayOfNext3Month => DateTime(year, month + 4, 0);

  //get first day of next month
  DateTime get firstDayNextMonth => DateTime(year, month + 1, 1);

  //get last day of next month next year
  DateTime get lastDayOfNextMonthNextYear => DateTime(year + 1, month + 2, 0);

  //get last day of next 2 month next year
  DateTime get lastDayOfNext2MonthNextYear => DateTime(year + 1, month + 3, 0);

  //get last day of next 3 month next year
  DateTime get lastDayOfNext3MonthNextYear => DateTime(year + 1, month + 4, 0);

  //next one year
  DateTime get nextYear => DateTime(year + 1, month, day);

  String get monthString => month < 10 ? '0$month' : month.toString();

  DateTime get tomorrow => add(const Duration(days: 1));

  DateTime get yesterday => subtract(const Duration(days: 1));

  bool isBeforeNow() => isBefore(DateTime.now());

  bool isAfterNow() => isAfter(DateTime.now());

  // 1/31   2/31
  // 1/30   2/30
  // 1/29   2/29
  DateTime get nextMonthSameDay => DateTime(year, month + 1, day);

  //契約日 1か月後 1か月後-1日
  // 1/31   2/28    2/27
  // 1/30   2/28    2/27
  // 1/29   2/28    2/27
  // 1/28   2/28    2/27
  // 1/27   2/27    2/26
  DateTime get nextMonthRelative {
    DateTime returnDate;
    final DateTime lastDayNextMonth =
        DateTime(year, month + 1, 1).lastDayOfMonth;
    final DateTime nextMonthExactly = nextMonthSameDay;
    if (nextMonthExactly.isAfter(lastDayNextMonth)) {
      returnDate = lastDayNextMonth;
    } else {
      returnDate = nextMonthExactly;
    }
    return returnDate;
  }

  ///+30 day
  DateTime get next30Day => add(const Duration(days: 30));

  bool isSameDay(DateTime otherDate) =>
      year == otherDate.year &&
      month == otherDate.month &&
      day == otherDate.day;

  //compare only day, month, year
  bool isBeforeByDay(DateTime otherDate) =>
      year < otherDate.year ||
      (year == otherDate.year && month < otherDate.month) ||
      (year == otherDate.year &&
          month == otherDate.month &&
          day < otherDate.day);

  //compare only day, month, year
  bool isAfterByDay(DateTime otherDate) =>
      year > otherDate.year ||
      (year == otherDate.year && month > otherDate.month) ||
      (year == otherDate.year &&
          month == otherDate.month &&
          day > otherDate.day);

  bool out30Day(DateTime otherDate) {
    final Duration diffDate = difference(otherDate);
    final bool out30Day = diffDate.compareTo(const Duration(days: 30)) > 0;
    return out30Day;
  }

  DateTime get lastMoment => DateTime(year, month, day, 23, 59, 59);
}
