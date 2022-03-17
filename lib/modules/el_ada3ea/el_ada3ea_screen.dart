import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class el_ada3ea_screen extends StatelessWidget {
  const el_ada3ea_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 90,),
          defaultButton(
            radius: 20,
            width: 200,
            function: () {},
            text: 'دعاء ختم القرءان',
            // style: TextStyle(fontSize: 30), ),
          ),
          SizedBox(height: 20,),

          defaultButton(
            radius: 20,
            width: 200,
            function: () {},
            text: 'ادعاء السفر',
            // style: TextStyle(fontSize: 30), ),
          ),
          SizedBox(height: 20,),

          defaultButton(
            radius: 20,
            width: 200,
            function: () {},
            text: 'اذكار الصباح والمساء',
            // style: TextStyle(fontSize: 30), ),
          ),
        ],
      ),
    );
  }
}
