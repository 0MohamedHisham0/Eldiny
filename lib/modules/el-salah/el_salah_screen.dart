import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/cubit/cubit.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class el_salah_screen extends StatelessWidget {
  const el_salah_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                       cubit.restLeftSalahNum();
                      },
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      'الصلوات المتروكة',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: CircleAvatar(
                          child: Text('${cubit.numberOfLeftSalah}'),
                          radius: 25,
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                defaultDivider(),
                SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration
                          child: CheckboxListTile(
                            title: const Text(
                              'الفجر',
                              style: TextStyle(fontSize: 20),
                            ),
                            secondary: const Icon(Icons.code),
                            autofocus: false,
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            selected: cubit.elFager,
                            value: cubit.elFager,
                            onChanged: (value) {
                              cubit.changeCheckBoxElFagrState();
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Center
                    ), //
                    SizedBox(
                      height: 3,
                    ), // SizedBox,
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration
                          child: CheckboxListTile(
                            title: const Text(
                              'الظهر',
                              style: TextStyle(fontSize: 20),
                            ),
                            secondary: const Icon(Icons.code),
                            autofocus: false,
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            selected: cubit.elZhar,
                            value: cubit.elZhar,
                            onChanged: (value) {
                              cubit.changeCheckBoxElZharState();
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Center
                    ), //SizedBox
                    SizedBox(
                      height: 3,
                    ), // SizedBox,
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration
                          child: CheckboxListTile(
                            title: const Text(
                              'العصر',
                              style: TextStyle(fontSize: 20),
                            ),
                            secondary: const Icon(Icons.code),
                            autofocus: false,
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            selected: cubit.elAser,
                            value: cubit.elAser,
                            onChanged: (value) {
                              cubit.changeCheckBoxElAserState();
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Center
                    ),
                    SizedBox(
                      height: 3,
                    ), // SizedBox,
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration
                          child: CheckboxListTile(
                            title: const Text(
                              'المغرب',
                              style: TextStyle(fontSize: 20),
                            ),
                            secondary: const Icon(Icons.code),
                            autofocus: false,
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            selected: cubit.elMagrb,
                            value: cubit.elMagrb,
                            onChanged: (value) {
                              cubit.changeCheckBoxElMagrState();
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Center
                    ),
                    SizedBox(
                      height: 3,
                    ), // SizedBox,
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration
                          child: CheckboxListTile(
                            title: const Text(
                              'العشاء',
                              style: TextStyle(fontSize: 20),
                            ),
                            secondary: const Icon(Icons.code),
                            autofocus: false,
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            selected: cubit.elAshaa,
                            value: cubit.elAshaa,
                            onChanged: (value) {
                              cubit.changeCheckBoxElAshaaState();
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Center
                    ), //SizedBox
                  ],
                )
              ],
            ),
          );
        },
        listener: (context, index) {});
  }
}
