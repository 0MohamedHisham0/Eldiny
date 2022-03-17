import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class renking_screen extends StatelessWidget {
  const renking_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('اكثر الاشخاص قراءه'),),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 180,top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                defaultButton(
                  radius: 20,
                  width: 200,
                  function: () {},
                  text: 'القارئ الاول',
                  // style: TextStyle(fontSize: 30), ),
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(
                  radius: 20,
                  width: 200,
                  function: () {},
                  text: 'القارئ الثاني',
                  // style: TextStyle(fontSize: 30), ),
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(
                  radius: 20,
                  width: 200,
                  function: () {},
                  text: 'القارئ الثالث',
                  // style: TextStyle(fontSize: 30), ),
                ),
              ],
            ),
          ),
        ));
  }
}
