import 'package:adealy/layout/layout_screen.dart';
import 'package:adealy/modules/login/login_screen.dart';
import 'package:adealy/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static late bool isLayout;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<Widget> checkUserToken() async {
    if (sharedPreferences.get("token") != null) {
      return const LayoutScreen();
    } else {
      return const LoginScreen();
    }
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
