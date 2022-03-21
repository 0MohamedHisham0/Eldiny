import 'package:adealy/network/local/CacheHelper.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static String token = "bearer ${CacheHelper.getData(key: "token") ?? ""}";

  static init() async {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://saif-my-appposts.herokuapp.com/",
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    if (dio == null) {
      init();
      return await dio!.get(url, queryParameters: query!);
    } else {
      return await dio!.get(url, queryParameters: query!);
    }
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Authorization': token,
    };
    if (dio == null) {
    init();
    return dio!.post(url, queryParameters: query, data: data);
    } else {
    return dio!.post(url, queryParameters: query, data: data);
    }
  }

  static Future<Response> postDataWithoutQuery({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    if (dio == null) {
      init();
      return dio!.post(url, data: data);
    } else {
      return dio!.post(url, data: data);
    }
  }
}
