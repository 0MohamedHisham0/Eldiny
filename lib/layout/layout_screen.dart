import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/cubit/cubit.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/drawer/drawer.dart';

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
          drawer: const drawer_Screen(),
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            selectedItemColor: Colors.blue,
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
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
