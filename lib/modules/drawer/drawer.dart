import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../el_ada3ea/el_ada3ea_screen.dart';
import '../ranking/ranking_screen.dart';

class drawer_Screen extends StatelessWidget {
  const drawer_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                )),
          ]),
          const SizedBox(
            height: 10,
          ),
          defaultTextButton(
              text: "الترتيب",
              function: () {
                navigateTo(context, const renking_screen());
              },
              isBold: true,
              fontSizeColor: Colors.blue,
              textFontSize: 20.0,
              textAlign: TextAlign.start),
          const SizedBox(
            height: 10,
          ),
          defaultDivider(paddingEnd: 0, paddingStart: 0),
          const SizedBox(
            height: 10,
          ),
          defaultTextButton(
              text: "الادعية",
              function: () {
                navigateTo(context, const el_ada3ea_screen());
              },
              isBold: true,
              fontSizeColor: Colors.blue,
              textFontSize: 20.0,
              textAlign: TextAlign.start),
          defaultDivider(paddingEnd: 0, paddingStart: 0),
        ],
      ),
    );
  }
}
