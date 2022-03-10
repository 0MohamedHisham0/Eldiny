import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/cubit/cubit.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentScreenIndex],
            ),
          ),
          body: cubit.screens[cubit.currentScreenIndex],
          drawer: Drawer(
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
                    function: () {},
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
                    function: () {},
                    isBold: true,
                    fontSizeColor: Colors.blue,
                    textFontSize: 20.0,
                    textAlign: TextAlign.start),
                defaultDivider(paddingEnd: 0, paddingStart: 0),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: Colors.blue),
            selectedItemColor: Colors.blue,
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            unselectedItemColor: Colors.grey,
            items: cubit.bottomItems,
            showUnselectedLabels: true,
            currentIndex: cubit.currentScreenIndex,
            onTap: (index) {
              cubit.changeScreenIndex(index);
            },
          ),
        );

      },
    );
  }
}
