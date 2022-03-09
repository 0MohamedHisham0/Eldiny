import 'package:adealy/shared/cubit/cubit.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ]),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Ranking',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'الادعية',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
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
