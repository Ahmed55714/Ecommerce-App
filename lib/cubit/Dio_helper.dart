// ignore_for_file: unnecessary_string_interpolations, file_names

import 'package:dio/dio.dart';

class Helper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers['Content-Type'] = 'application/json';
    dio!.options.headers['lang'] = lang;
    dio!.options.headers['Authorization'] = "$token";

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers['Content-Type'] = 'application/json';
    dio!.options.headers['lang'] = "$lang";
    dio!.options.headers['Authorization'] = "$token";
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    required String? token,
  }) async {
    dio!.options.headers['Content-Type'] = 'application/json';
    dio!.options.headers['lang'] = "$lang";
    dio!.options.headers['Authorization'] = "$token";
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
