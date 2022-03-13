import 'dart:convert';

import 'package:adealy/app_icons.dart';
import 'package:adealy/models/surah/surah_list.dart';
import 'package:adealy/modules/el-khatma/el_khatma_screen.dart';
import 'package:adealy/modules/el-quran/el_quran.dart';
import 'package:adealy/modules/el-salah/el_salah_screen.dart';
import 'package:adealy/modules/el-tlawa/el_tlawa_screen.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

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
    const BottomNavigationBarItem(
      icon: Icon(AppIcons.koran),
      label: "القرآن",
    ),
    const BottomNavigationBarItem(
        icon: Icon(AppIcons.praying), label: "الصلاه"),
    const BottomNavigationBarItem(
        icon: Icon(AppIcons.el_telawa), label: "التلاوه"),
    const BottomNavigationBarItem(
        icon: Icon(AppIcons.open_hand), label: "الخاتمة"),
  ];

  void changeScreenIndex(int index) {
    currentScreenIndex = index;
    emit(ChangeScreenIndexState());
  }

  late Database database;

  bool elFager = false;
  bool elZhar = false;
  bool elAser = false;
  bool elMagrb = false;
  bool elAshaa = false;

  void changeCheckBoxElFagrState() {
    elFager = !elFager;
    updateOneItemFromDb("fagr", boolToString(elFager));
    emit(ChangeCheckBoxElFagrState());
  }

  void changeCheckBoxElZharState() {
    elZhar = !elZhar;
    updateOneItemFromDb("zohr", boolToString(elZhar));
    emit(ChangeCheckBoxElZharState());
  }

  void changeCheckBoxElAserState() {
    elAser = !elAser;
    updateOneItemFromDb("aser", boolToString(elAser));
    emit(ChangeCheckBoxElAserState());
  }

  void changeCheckBoxElMagrState() {
    elMagrb = !elMagrb;
    updateOneItemFromDb("magrb", boolToString(elMagrb));
    emit(ChangeCheckBoxElMagrbState());
  }

  void changeCheckBoxElAshaaState() {
    elAshaa = !elAshaa;
    updateOneItemFromDb("ashaa", boolToString(elAshaa));
    emit(ChangeCheckBoxElAshaaState());
  }

  int numberOfLeftSalah = 0;

  Future<Database> createDb() async {
    database = await openDatabase("Salah.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Salah (id INTEGER PRIMARY KEY, num INTEGER,fagr TEXT,zohr TEXT,aser TEXT,magrb TEXT,ashaa TEXT,nowDate TEXT)');
    });
    onOpenApp();
    return database;
  }

  Future<List<Map<String, dynamic>>> getDataBase() async {
    List<Map<String, dynamic>> dbList =
        (await database.rawQuery('SELECT * FROM Salah WHERE id = ?', [1]));
    return dbList;
  }

  void onOpenApp() {
    int counter = 0;
    var leftDays = 0;
    getDataBase().then((dbList) => {
          if (dbList.isEmpty)
            {
              insertSalah(database),
            }
          else
            {
              if (DateTime.parse(dbList.first["nowDate"]).month == getNowDate().month)
                {
                  print("same month"),
                  if (DateTime.parse(dbList.first["nowDate"]).day !=
                      getNowDate().day)
                    {
                      leftDays = getNowDate().day -
                          DateTime.parse(dbList.first["nowDate"]).day,
                      print("leftDays $leftDays"),
                      if (leftDays == 1)
                        {
                          if (dbList[0]["fagr"] == "0") {counter++},
                          if (dbList[0]["zohr"] == "0") {counter++},
                          if (dbList[0]["aser"] == "0") {counter++},
                          if (dbList[0]["magrb"] == "0") {counter++},
                          if (dbList[0]["ashaa"] == "0") {counter++},
                          updateNumOfLeft(dbList[0]["num"] + counter),

                          print("one day "),
                          updateAllElSalah("0", "0", "0", "0", "0"),
                          //update Now date
                          updateOneItemFromDb(
                              "nowDate", getNowDate().toString()),
                          emit(ChangeNumberOfLeftSalahState()),
                        },
                      if (leftDays > 1)
                        {
                          if (dbList[0]["fagr"] == "0") {counter++},
                          if (dbList[0]["zohr"] == "0") {counter++},
                          if (dbList[0]["aser"] == "0") {counter++},
                          if (dbList[0]["magrb"] == "0") {counter++},
                          if (dbList[0]["ashaa"] == "0") {counter++},
                          updateNumOfLeft(dbList[0]["num"] +
                              counter +
                              ((leftDays - 1) * 5)),
                          print("counter $counter"),
                          print("multiDays"),

                          updateAllElSalah("0", "0", "0", "0", "0"),
                          //update Now date
                          updateOneItemFromDb(
                              "nowDate", getNowDate().toString()),
                          emit(ChangeNumberOfLeftSalahState()),
                        },
                    }
                }
            },

          numberOfLeftSalah = dbList[0]["num"],
          emit(ChangeNumberOfLeftSalahState()),

          elFager = stringToBool(dbList[0]["fagr"]),
          elZhar = stringToBool(dbList[0]["zohr"]),
          elAser = stringToBool(dbList[0]["aser"]),
          elMagrb = stringToBool(dbList[0]["magrb"]),
          elAshaa = stringToBool(dbList[0]["ashaa"]),

          emit(ChangeCheckBoxElFagrState()),
          emit(ChangeCheckBoxElZharState()),
          emit(ChangeCheckBoxElAserState()),
          emit(ChangeCheckBoxElMagrbState()),
          emit(ChangeCheckBoxElAshaaState()),
        });
  }

  void updateNumOfLeft(int updateValue) async {
    await database.rawUpdate('UPDATE Salah SET num = ?', ['$updateValue']);
    numberOfLeftSalah = updateValue;
    emit(ChangeNumberOfLeftSalahState());
  }

  void updateAllElSalah(
      String fagr, String zohr, String aser, String magrb, String ashaa) async {
    await database.rawUpdate(
        'UPDATE Salah SET fagr = ?,zohr = ?,aser = ?,magrb = ?,ashaa = ?',
        [fagr, zohr, aser, magrb, ashaa]);

    elFager = stringToBool(fagr);
    elZhar = stringToBool(zohr);
    elAser = stringToBool(aser);
    elMagrb = stringToBool(magrb);
    elAshaa = stringToBool(ashaa);

    emit(ChangeCheckBoxElFagrState());
    emit(ChangeCheckBoxElZharState());
    emit(ChangeCheckBoxElAserState());
    emit(ChangeCheckBoxElMagrbState());
    emit(ChangeCheckBoxElAshaaState());
  }

  Future<void> updateOneItemFromDb(String item, String valueOfItem) async {
    await database.rawUpdate('UPDATE Salah SET $item = ?', [valueOfItem]);
  }

  Future<void> insertSalah(database) async {
    // Insert some records in a transaction
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Salah(num,fagr ,zohr ,aser ,magrb ,ashaa ,nowDate) VALUES("0","0","0","0","0","0","${getNowDate()}")');
    });
  }

  Future<void> deleteDataFromDb(database) async {
    // Delete a record
    await database.rawDelete('DELETE FROM Salah WHERE id = ?', [1]);
  }

  void restLeftSalahNum() {
    updateNumOfLeft(0);
    emit(ChangeNumberOfLeftSalahState());
  }

  //quranApi
  static Future<SurahsList> getSurahList() async {
    String url = "http://api.alquran.cloud/v1/quran/quran-uthmani";

    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      // // cache in Hive
      // await _hiveBox.put(
      //   'surahList',
      //   SurahsList.fromJSON(
      //     json.decode(response.body),
      //   ),
      // );

      return SurahsList.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Post");
    }
  }

}
