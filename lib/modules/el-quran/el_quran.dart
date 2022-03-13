import 'package:adealy/modules/el-quran/surah-quran/surah-quran_screen.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class el_quran_screen extends StatelessWidget {
  const el_quran_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              defaultButton(
                radius: 20,
                width: 200,
                function: () {},
                text: 'استئناف القراءه',
                // style: TextStyle(fontSize: 30), ),
              ),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                radius: 20,

                width: 200,
                function: () {
                  navigateAndFinishTo(context, Surah_Quran_Screen());
                },
                text: 'سور القراءه',
                // style: TextStyle(fontSize: 30), ),
              ),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                radius: 20,

                width: 200,
                function: () {},
                text: 'اجزاء القراءه',
                // style: TextStyle(fontSize: 30), ),
              ),

            ],
          ),
        ));
  }
}
