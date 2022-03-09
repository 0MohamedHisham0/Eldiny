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
