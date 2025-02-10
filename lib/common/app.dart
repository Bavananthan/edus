import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../provider/locator.dart';
import '../widgets/common_loader.dart';
import 'asserts.dart';

class App {
  // make a digit digit as two digit text Ex:- 1 => 01
  // and make text with super text and related with above function
  static String _makeTwoDigit(int digit, {bool needSupText = false}) {
    String value = "";
    try {
      value = digit.toString().length == 1 ? "0$digit" : digit.toString();
      if (needSupText) {
        if (digit == 1) {
          value = "$value st"; //1st \u02e2\u1d57
        } else if (digit == 2) {
          value = "$value nd"; //2nd \u207f\u1d48
        } else if (digit == 3) {
          value = "$value rd"; //3rd \u02b3\u1d48
        } else {
          value = "$value th"; //nth \u1d57\u02b0
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return value;
  }

  String timeFormat(DateTime? dt, {bool toLocal = false}) {
    String value = "";
    try {
      if (dt != null) {
        DateTime dateTime = !toLocal ? dt : dt.toLocal();
        String hr = _makeTwoDigit(dateTime.hour == 0
            ? 12
            : dateTime.hour > 12
                ? dateTime.hour - 12
                : dateTime.hour);
        String minutes = _makeTwoDigit(dateTime.minute);
        String amPm = dateTime.hour >= 12 ? "PM" : "AM";
        value = "$hr:$minutes $amPm";
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  // get month in text format like Jan,Feb,Oct
  static String _getMonthText(int month) {
    String value = "";
    try {
      switch (month) {
        case 1:
          value = "Jan";
          break;
        case 2:
          value = "Feb";
          break;
        case 3:
          value = "Mar";
          break;
        case 4:
          value = "Apr";
          break;
        case 5:
          value = "May";
          break;
        case 6:
          value = "Jun";
          break;
        case 7:
          value = "Jul";
          break;
        case 8:
          value = "Aug";
          break;
        case 9:
          value = "Sep";
          break;
        case 10:
          value = "Oct";
          break;
        case 11:
          value = "Nov";
          break;
        case 12:
          value = "Dec";
          break;
        default:
          return "";
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  // get month in text format like Jan,Feb,Oct
  static String _getDayText(int day, {bool full = false}) {
    String value = "";
    try {
      switch (day) {
        case 1:
          value = full ? "Monday" : "Mon";
          break;
        case 2:
          value = full ? "Tuesday" : "Tue";
          break;
        case 3:
          value = full ? "Wednesday" : "Wed";
          break;
        case 4:
          value = full ? "Thursday" : "Thu";
          break;
        case 5:
          value = full ? "Friday" : "Fri";
          break;
        case 6:
          value = full ? "Saturday" : "Sat";
          break;
        case 7:
          value = full ? "Sunday" : "Sun";
          break;
        default:
          return "";
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  String dateFormat(DateTime? dateTime) {
    String value = "";
    try {
      if (dateTime != null) {
        String day = _makeTwoDigit(dateTime.day);
        String month = _makeTwoDigit(dateTime.month);

        value = "${dateTime.year}-$month-$day";
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  String dateFormatMonthText(DateTime? dateTime) {
    String value = "";
    try {
      if (dateTime != null) {
        String day = _makeTwoDigit(dateTime.day);
        String monthText = _getMonthText(dateTime.month);

        value = "$monthText, $day, ${dateTime.year},";
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  String formatTimeToAmPm(String time) {
    try {
      List<String> parts = time.split(":");
      if (parts.length != 3) {
        return "";
      }

      int hour = int.parse(parts[0]);
      String minutes = parts[1];
      String amPm = hour >= 12 ? "PM" : "AM";

      hour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

      String formattedHour = _makeTwoDigitTime(hour);

      return "$formattedHour:$minutes $amPm";
    } catch (e) {
      return "";
    }
  }

  String _makeTwoDigitTime(int num) {
    return num.toString().padLeft(2, '0');
  }

  String dateTimeFormatFromString(String dateTimeString,
      {bool dateOnly = false, bool withSlack = false, bool dayInText = false}) {
    String value = "";
    try {
      DateTime? dt = DateTime.parse(App.checkHasZ(dateTimeString));
      DateTime? dateTime = dt.toLocal();
      // ignore: unnecessary_null_comparison
      if (dateTime != null) {
        String dayText = dayInText ? _getDayText(dateTime.weekday) : "";
        String monthText = _getMonthText(dateTime.month);
        String date = _makeTwoDigit(dateTime.day);
        String hr = _makeTwoDigit(dateTime.hour == 0
            ? 12
            : dateTime.hour > 12
                ? dateTime.hour - 12
                : dateTime.hour);
        String minutes = _makeTwoDigit(dateTime.minute);
        String amPm = dateTime.hour >= 12 ? "PM" : "AM";
        if (!withSlack) {
          if (!dateOnly) {
            value = (!dayInText)
                ? "$date $monthText, ${dateTime.year} $hr:$minutes $amPm"
                : "$dayText, $monthText $date $hr:$minutes $amPm";
          } else {
            value = "$date $monthText, ${dateTime.year}";
          }
        } else {
          value = "$date/$monthText/${dateTime.year} $hr:$minutes $amPm";
        }
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  List<String> formatStartEndDate(
      String startDateTimeString, String endDateTimeString,
      {bool dateOnly = false, bool withSlack = false, bool dayInText = false}) {
    String formattedStartDate = "";
    String formattedEndDate = "";
    String formattedEnd = "";

    try {
      DateTime? startDt = DateTime.parse(App.checkHasZ(startDateTimeString));
      DateTime? startDateTime = startDt.toLocal();

      DateTime? endDt = DateTime.parse(App.checkHasZ(endDateTimeString));
      DateTime? endDateTime = endDt.toLocal();

      bool sameYear = startDateTime.year == endDateTime.year;
      bool sameMonth = startDateTime.month == endDateTime.month;

      formattedStartDate = dateTimeFormatFromDateTime(startDateTime,
          dateOnly: dateOnly,
          withSlack: withSlack,
          dayInText: dayInText,
          omitYear: sameYear,
          omitMonth: sameMonth && sameYear);

      formattedEndDate = dateTimeFormatFromDateTime(endDateTime,
          dateOnly: dateOnly,
          withSlack: withSlack,
          dayInText: dayInText,
          omitYear: sameYear,
          omitMonth: sameMonth && sameYear);
      if (sameMonth && sameYear) {
        if (!dayInText) {
          formattedEnd =
              "${_getMonthText(endDateTime.month)}, ${endDateTime.year.toString()}";
        } else {
          formattedEnd =
              "${endDateTime.month.toString()}, ${endDateTime.year.toString()}";
        }
      } else if (sameYear) {
        formattedEnd = ", ${endDateTime.year.toString()}";
      }
    } catch (e) {
      formattedStartDate = "";
      formattedEndDate = "";
      formattedEnd = "";
    }

    return [formattedStartDate, formattedEndDate, formattedEnd];
  }

  String dateTimeFormatFromDateTime(DateTime dateTime,
      {bool dateOnly = false,
      bool withSlack = false,
      bool dayInText = false,
      bool omitYear = false,
      bool omitMonth = false}) {
    String value = "";
    try {
      String dayText = dayInText ? _getDayText(dateTime.weekday) : "";
      String monthText = _getMonthText(dateTime.month);
      String date = _makeTwoDigit(dateTime.day);
      String hr = _makeTwoDigit(dateTime.hour == 0
          ? 12
          : dateTime.hour > 12
              ? dateTime.hour - 12
              : dateTime.hour);
      String minutes = _makeTwoDigit(dateTime.minute);
      String amPm = dateTime.hour >= 12 ? "PM" : "AM";

      if (!withSlack) {
        if (!dateOnly) {
          if (omitMonth && omitYear) {
            value = (!dayInText)
                ? "$date $hr:$minutes $amPm"
                : "$dayText $date $hr:$minutes $amPm";
          } else {
            value = (!dayInText)
                ? "$date ${omitMonth ? '' : monthText}${omitYear ? '' : ', ${dateTime.year}'} $hr:$minutes $amPm"
                : "$dayText, ${omitMonth ? '' : monthText} $date $hr:$minutes $amPm";
          }
        } else {
          value =
              "$date ${omitMonth ? '' : monthText}${omitYear ? '' : ', ${dateTime.year}'}";
        }
      } else {
        value =
            "$date/${omitMonth ? '' : monthText}/${dateTime.year} $hr:$minutes $amPm";
      }
    } catch (e) {
      value = "";
    }
    return value;
  }

  static String checkHasZ(String? date) {
    String val = "";
    if (date != null && date != "") {
      if (date.toLowerCase().endsWith('z')) {
        val = date;
      } else {
        val = "${date}Z";
      }
    }
    return val;
  }

  // this function will convert the date time for local format
  static String toLocal(String dateTime) {
    try {
      DateTime utc = DateTime.parse(dateTime);
      DateTime utcDate = DateTime.utc(
          utc.year, utc.month, utc.day, utc.hour, utc.minute, utc.second);
      final localTime = utcDate.toLocal();
      debugPrint(localTime.toString());
      return localTime.toString();
    } catch (exception) {
      DateTime date = DateTime.now();

      return date.toLocal().toString();
    }
  }

  showRestrictPopLoading(BuildContext context,
      {Color? circularColor, bool ableToPop = false}) {
    PopScope pop = PopScope(
        canPop: ableToPop,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: SimpleDialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              contentPadding: const EdgeInsets.all(24.0),
              children: <Widget>[
                Center(
                  child: CommonLoader(
                    animationPath: animation,
                    message: "Loading...............",
                  ),

                  // CircularProgressIndicator(
                  //   valueColor: AlwaysStoppedAnimation<Color>(
                  //       circularColor ?? colors.brandColor),
                  // ),
                )
              ]),
        ));
    showDialog(
      barrierColor: Colors.white.withOpacity(0.3),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return pop;
      },
    );
  }

  // flush bar for info like snack bar
  void showFlashNotification(
      {required String msg,
      String? title,
      Color? textColor,
      Color? bgColor,
      Widget? leadIcon,
      bool showInBottom = true}) {
    showOverlayNotification(
      (ctx) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: bgColor ?? colors.red,
            margin: showInBottom ? null : const EdgeInsets.all(0.0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0,
                  /* MediaQuery.of(ctx).viewInsets.bottom + */ 8.0),
              // margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: bgColor ?? colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: SafeArea(
                bottom: showInBottom,
                top: !showInBottom,
                child: Row(
                  children: [
                    leadIcon ?? const SizedBox.shrink(),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null) ...[
                            Text(title,
                                style: TextStyle(
                                  color: textColor ?? colors.white,
                                  fontSize: 15.0,
                                ),
                                maxLines: 3),
                            const SizedBox(height: 4.0)
                          ],
                          Text(msg,
                              style: TextStyle(
                                color: textColor ?? colors.white,
                                fontSize: 14.5,
                              ),
                              maxLines: 10),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => OverlaySupportEntry.of(ctx)?.dismiss(),
                      child: Icon(
                        Icons.close_sharp,
                        color: textColor ?? colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      position:
          showInBottom ? NotificationPosition.bottom : NotificationPosition.top,
      duration: const Duration(seconds: 3),
    );
  }

  //Print Statement for Debugging
  printStatement(dynamic status) {
    if (kDebugMode) {
      debugPrint("----------------------------------------");
      print(status);
      debugPrint("----------------------------------------");
    }
  }

  // pop screen once
  void popOnce(BuildContext context) => Navigator.of(context).pop();
}
