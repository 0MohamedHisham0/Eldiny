import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class el_khatma_screen extends StatelessWidget {
  const el_khatma_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                        margin: const EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            width: 50,
                            height: 240,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15,right: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/images/user.jpg"),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Hassen Ahmed',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width:10,
                                    ),
                                    defaultButton(
                                      radius: 20,
                                      width: 130,
                                      function: () {},
                                      text: 'Join now',
                                      // style: TextStyle(fontSize: 30), ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    const CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                      AssetImage("assets/images/user.jpg"),
                                    ),
                                    const CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                      AssetImage("assets/images/user.jpg"),
                                    ),
                                    const CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                      AssetImage("assets/images/user.jpg"),
                                    ),
                                  ],
                                )
                              ],
                            ))),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
