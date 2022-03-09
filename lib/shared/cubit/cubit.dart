import 'package:adealy/modules/el-khatma/el_khatma_screen.dart';
import 'package:adealy/modules/el-quran/el_quran.dart';
import 'package:adealy/modules/el-salah/el_salah_screen.dart';
import 'package:adealy/modules/el-tlawa/el_tlawa_screen.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentScreenIndex = 0;

  List<Widget> screens = [
    const el_quran_screen(),
    const el_salah_screen(),
    const el_tlawa_screen(),
    const el_khatma_screen(),
  ];

  List<String> titles = [
    'القران الكريم',
    'الصلاه',
    'التلاوة',
    'الخاتمة علي روح المتوفي',
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "القرآن"),
    const BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "الصلاه"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.menu_book), label: "التلاوه"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.menu_book), label: "الخاتمة"),
  ];

  void changeScreenIndex(int index) {
    currentScreenIndex = index;
    emit(ChangeScreenIndexState());
  }
}
