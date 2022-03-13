import 'dart:ffi';

import 'package:flutter/material.dart';

void navigateAndFinishTo(context, screen) {
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
