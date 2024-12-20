import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 日期工具
class DateUtil {
  /// 日期格式，年份，例如：2004，2008
  static const String dateFormatYYYY = "yyyy";

  /// 日期格式，月年，例如：00/0000
  static const String dateFormatMMYYYY = "MM/yyyy";

  /// 日期格式，年份和月份，例如：200707，200808
  static const String dateFormatYYYYMM = "yyyyMM";

  /// 日期格式，年份和月份，例如：200707，2008-08
  static const String dateFormatLineYYYYMM = "yyyy-MM";

  /// 日期格式，月年，例如：YYYY.MM
  static const String dateFormatYYYYDotMM = "yyyy.MM";

  /// 日期格式，年月日，例如：050630，080808
  static const String dateFormatYYMMDD = "yyMMdd";

  /// 日期格式，年月日，用横杠分开，例如：06-12-25，08-08-08
  static const String dateFormatLineYYMMDD = "yy-MM-dd";

  /// 日期格式，年月日，例如：20050630，20080808
  static const String dateFormatYYYYMMDD = "yyyyMMdd";

  /// 日期格式，年月日，用横杠分开，例如：2006-12-25，2008-08-08
  static const String dateFormatLineYYYYMMDD = "yyyy-MM-dd";

  /// 日期格式，年月日，例如：2016.10.05
  static const String dateFormatDotYYYYMMDD = "yyyy.MM.dd";

  /// 日期格式，年月日，例如：2016.10.05 12:30
  static const String dateFormatDotYYYYMMDDHHMM = "yyyy.MM.dd HH:mm";

  /// 日期格式，年月日，例如：2016年10月05日
  static const String dateFormatDateYYYYMMDD = "yyyy年MM月dd日";

  /// 日期格式，年月日，例如：2016年10月
  static const String dateFormatDateYYYYMM = "yyyy年MM月";

  /// 日期格式，月日，例如：10月05日
  static const String dateFormatDateMMDD = "MM月dd日";

  /// 日期格式，月日，例如：10-05
  static const String dateFormatDateMMLineDD = "MM-dd";

  /// 日期格式，月日，例如：10.05
  static const String dateFormatDateMMDotDD = "MM.dd";

  /// 日期格式，年月日，例如：2016年10月5日
  static const String dateFormatDateYYYYMD = "yyyy年M月d日";

  /// 日期格式，月日，例如：10月5日
  static const String dateFormatDateMD = "M月d日";

  /// 日期格式，年月日时分，例如：200506301210，200808081210
  static const String dateFormatYYYYMMDDHHMM = "yyyyMMddHHmm";

  /// 日期格式，年月日时分，例如：20001230 12:00，20080808 20:08
  static const String dateFormatYYYYMMDDDotHHMM = "yyyyMMdd HH:mm";

  /// 日期格式，年月日时分，例如：2000-12-30 12:00，2008-08-08 20:08
  static const String dateFormatLineYYYYMMDDDotHHMM = "yyyy-MM-dd HH:mm";

  /// 日期格式，年月日时分秒，例如：20001230120000，20080808200808
  static const String dateFormatYYYYMMDDHHMMSS = "yyyyMMddHHmmss";

  /// 日期格式，年月日时分秒，年月日用横杠分开，时分秒用冒号分开
  /// 例如：2005-05-10 23：20：00，2008-08-08 20:08:08
  static const String dateFormatLineYYYYMMDDDotHHMMSS = "yyyy-MM-dd HH:mm:ss";

  /// 日期格式，年月日时分秒，年月日用横杠分开，时分秒用冒号分开
  /// 例如：2005.05.10 23：20：00，2008.08.08 20:08:08
  static const String dateFormatDotYYYYMMDDDotHHMM = "yyyy.MM.dd HH:mm";

  /// 日期格式，年月日时分秒毫秒，例如：20001230120000123，20080808200808456
  static const String dateFormatYYYYMMDDHHMMSSSSS = "yyyyMMddHHmmssSSS";

  /// 日期格式，月日时分，例如：10-05 12:00
  static const String dateFormatMMDDHHMM = "MM-dd HH:mm";

  /// 日期格式，月日时分，例如：10-05 12:00
  static const String dateFormatMMDDHHMMSS = "MM-dd HH:mm:ss";

  /// 日期格式，时分，例如：12:00
  static const String dateFormatHHMM = "HH:mm";

  ///补零
  static String zeroFill(int i) {
    return i >= 10 ? "$i" : "0$i";
  }

  /// 秒转时分秒
  static String second2HMS(int sec, {bool isEasy = true}) {
    String hms = "00:00:00";
    if (!isEasy) hms = "00时00分00秒";
    if (sec > 0) {
      int h = sec ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = "${zeroFill(h)}:${zeroFill(m)}:${zeroFill(s)}";
      if (!isEasy) hms = "${zeroFill(h)}时${zeroFill(m)}分${zeroFill(s)}秒";
    }
    return hms;
  }

  /// 秒转天时分秒
  static String second2DHMS(int sec) {
    String hms = "00天00时00分00秒";
    if (sec > 0) {
      int d = sec ~/ 86400;
      int h = (sec % 86400) ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = "${zeroFill(d)}天${zeroFill(h)}时${zeroFill(m)}分${zeroFill(s)}秒";
    }
    return hms;
  }

  /// 秒转天时分秒
  /// 补零列表长度4，0-日(00) 1-时(00) 2-分(00) 3-秒(00)
  static List<String> second2ListStr(int sec) {
    List<String> list = [];
    if (sec > 0) {
      list[0] = zeroFill(sec ~/ 86400); //日
      list[1] = zeroFill((sec % 86400) ~/ 3600); //时
      list[2] = zeroFill((sec % 3600) ~/ 60); //分
      list[3] = zeroFill(sec % 60); //秒
    } else {
      for (int i = 0; i < list.length; i++) {
        list[i] = "00";
      }
    }
    return list;
  }

  /// 秒转天时分秒
  /// 列表长度4，0-日 1-时 2-分 3-秒
  static List<int> second2List(int sec) {
    List<int> list = [];
    if (sec > 0) {
      list[0] = sec ~/ 86400; //日
      list[1] = (sec % 86400) ~/ 3600; //时
      list[2] = (sec % 3600) ~/ 60; //分
      list[3] = sec % 60; //秒
    } else {
      for (int i = 0; i < list.length; i++) {
        list[i] = 0;
      }
    }
    return list;
  }

  /// 时间格式化，指定输入输出形式
  static String formatDateString(
      String dateString, String fromPattern, String toPattern) {
    if (dateString.isEmpty) {
      return '';
    }
    DateFormat fromDateFormat = DateFormat(fromPattern);
    DateTime dateTime;
    if (isOnlyNum(dateString)) {
      if (fromPattern.contains('y')) {
        fromPattern = fromPattern.replaceAll('y', 'Y');
      }
      if (fromPattern.contains('d')) {
        fromPattern = fromPattern.replaceAll('d', 'D');
      }
      dateTime = FixedDateTimeFormatter(fromPattern).decode(dateString);
    } else {
      dateTime = fromDateFormat.parse(dateString);
    }
    DateFormat toDateFormat = DateFormat(toPattern);
    return toDateFormat.format(dateTime);
  }

  /// 格式化 DateTime 为指定格式 String 日期
  static String formatDateTime(String pattern, DateTime dateTime) {
    return DateFormat(pattern).format(dateTime);
  }

  /// 格式化 string 时间为 DateTime
  /// * `Y`	for “calendar year”
  /// * `M`	for “calendar month”
  /// * `D`	for “calendar day”
  /// * `E`	for “decade”
  /// * `C`	for “century”
  /// * `h`	for “clock hour”
  /// * `m`	for “clock minute”
  /// * `s`	for “clock second”
  /// * `S`	for “fractional clock second”
  static DateTime? formatStringToDate(String pattern, String dateString) {
    try {
      if (isOnlyNum(dateString)) {
        if (pattern.contains('y')) {
          pattern = pattern.replaceAll('y', 'Y');
        }
        if (pattern.contains('d')) {
          pattern = pattern.replaceAll('d', 'D');
        }
        return FixedDateTimeFormatter(pattern).decode(dateString);
      }
      return DateFormat(pattern).parse(dateString);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 计算两个时间相差多久 天：inDays 小时：inHours 分钟：inMinutes
  static Duration getDateDifference(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate);
  }

  /// 判断是否是纯数字
  static bool isOnlyNum(String input) {
    RegExp regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(input);
  }

  /// 判断两个日期是否是同一天
  static bool isSameDay(DateTime date, DateTime otherDate) {
    return date.year == otherDate.year &&
        date.month == otherDate.month &&
        date.day == otherDate.day;
  }

  /// 是否是闰年
  static bool isLeapYear(int year) {
    return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
  }

  /// 获取指定年-月有几天
  int getMonthDays(int year, int month) {
    int count = 0;
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      count = 31;
    }
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      count = 30;
    }
    //判断平年与闰年
    if (month == 2) {
      if (isLeapYear(year)) {
        count = 29;
      } else {
        count = 28;
      }
    }
    return count;
  }
}
