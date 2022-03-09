import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class el_khatma_screen extends StatelessWidget {
  const el_khatma_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.all(10),
                    child: Container(
                        color: Colors.grey,
                        width: 320,
                        height: 240,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
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
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 120,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Join now',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))),
                                SizedBox(
                                  width: 100,
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage("assets/images/user.jpg"),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage("assets/images/user.jpg"),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage("assets/images/user.jpg"),
                                ),
                              ],
                            )
                          ],
                        )));
              },
            ),
          )
        ],
      ),
    );
  }
}
