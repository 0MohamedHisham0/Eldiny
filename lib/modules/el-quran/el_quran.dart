import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class el_quran_screen extends StatelessWidget {
  const el_quran_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 170,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'استئناف القراءه',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'سور القراءه',
                style: TextStyle(fontSize: 25),
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'اجزاء القراءه',
                style: TextStyle(fontSize: 25),
              )),
        ),
      ],
    ));
  }
}
