import 'package:intl/intl.dart';

const String kCommonResponseDatePattern = "yyyy-MM-dd HH:mm:ss.SSSZ";
const String kSecondResponseDatePattern = "dd-MM-yyyy";
const String kSecondResponseDateHourPattern = "dd-MM-yyyy ~HH'H'";
const String kYearMonthDate = "yyyy/MM/dd";
const String kYearMonthDateRequestBackEnd = "yyyy-MM-dd";
const String kYearMonthDateResponseBackEnd = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
const String kSimpleDatePattern = 'MM/dd/yyyy';
const String kVietNamDatePattern = 'dd/MM/yyyy';
const String kVietNamDateTimePattern = 'dd/MM/yyyy HH:mm';
const String kEndPeriodDatePattern = "yyyy-MM-dd HH:mm";
const String kTimePaymentDatePattern = "yyMMdd_hhmmss";

class DateUtil {
  static String getCurrentDateString(String pattern) {
    return DateFormat(pattern).format(DateTime.now());
  }

  static String format(
    String pattern,
    DateTime dateTime, {
    String? errorReturn,
  }) {
    try {
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      // logger.e(e);
      if (errorReturn != null) {
        return errorReturn;
      } else {
        rethrow;
      }
    }
  }

  static DateTime parse(
    String pattern,
    String inputString, {
    DateTime? errorReturn,
  }) {
    try {
      return DateFormat(pattern).parseStrict(inputString).toLocal();
    } catch (e) {
      // logger.e(e);
      if (errorReturn != null) {
        return errorReturn;
      } else {
        rethrow;
      }
    }
  }

  //ISO-8601
  static DateTime parseV2(
    String inputString, {
    DateTime? errorReturn,
  }) {
    try {
      return DateTime.parse(inputString).toLocal();
    } catch (e) {
      if (errorReturn != null) {
        return errorReturn;
      } else {
        // logger.e(e);
        rethrow;
      }
    }
  }

  static String reformat(
    String currentPattern,
    String newPattern,
    String inputString, {
    String? errorReturn,
  }) {
    try {
      //convert string to DateTime
      final DateTime dateTime = DateFormat(currentPattern).parse(inputString);

      return DateFormat(newPattern).format(dateTime);
    } catch (e) {
      if (errorReturn != null) {
        return errorReturn;
      } else {
        rethrow;
      }
    }
  }

  static DateTime? commonParse(String? inputString) {
    try {
      return inputString == null
          ? null
          : DateFormat(kCommonResponseDatePattern).parse(inputString).toLocal();
    } catch (e) {
      // logger.e(e);
      return null;
    }
  }

  static String toPattern(String pattern, String? inputString) {
    try {
      return inputString == null
          ? ''
          : format(
              pattern,
              DateFormat(kCommonResponseDatePattern).parse(inputString),
            );
    } catch (e) {
      // logger.e(e);
      return '';
    }
  }

  static String toPatternV2(
    String pattern,
    String inputString, {
    String? errorReturn,
  }) {
    try {
      return format(pattern, DateTime.parse(inputString));
    } catch (e) {
      // logger.e(e);
      return errorReturn ?? '';
    }
  }

  static bool isDate(String input, String format) {
    try {
      DateFormat(format).parseStrict(input);

      return true;
    } catch (e) {
      return false;
    }
  }
}

List<int> _leapYearMonths = const <int>[1, 3, 5, 7, 8, 10, 12];

int calcDateCount(int year, int month) {
  if (_leapYearMonths.contains(month)) {
    return 31;
  } else if (month == 2) {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      return 29;
    }

    return 28;
  }

  return 30;
}
