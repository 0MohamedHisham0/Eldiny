
import 'package:flutter/material.dart';


void navigateTo(context, screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: screen,
      ),
    ),
  ).then((value) => {Navigator.pop(context)});
}

bool stringToBool(String string) {
  return int.parse(string) == 0 ? false : true;
}

String boolToString(bool bool) {
  return bool ? "1" : "0";
}

DateTime getNowDate() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  return date;
}

String getCurrentTimeStamp() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

TimeOfDay toTimeOfDay(String s) {
  String min, hour;
  hour = s.split(":")[0].replaceAll("TimeOfDay(", "");
  min = s.split(":")[1].replaceAll(")", "");
  return TimeOfDay(hour: int.parse(hour), minute: int.parse(min));
}

// String formatDate(String date) {
//   return DateFormat("EEE, d MMM yyyy HH:mm:ss").format(DateTime.parse(date));
// }
