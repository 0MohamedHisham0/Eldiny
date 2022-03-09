import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class el_salah_screen extends StatelessWidget {
  const el_salah_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CircleAvatar(child: Text('20')),
            ),
            Expanded(child: Text('الصلوات المتروكة')),
            Expanded(
                child: ElevatedButton(onPressed: () {}, child: Text('مسح')))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    'الفجر',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 240,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank))
                ],
              ),
              Row(
                children: [
                  Text(
                    'الظهر',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 240,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank))
                ],
              ),
              Row(
                children: [
                  Text(
                    'العصر',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 235,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank))
                ],
              ),
              Row(
                children: [
                  Text(
                    'المغرب',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 222,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank))
                ],
              ),
              Row(
                children: [
                  Text(
                    'العشاء',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 230,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
