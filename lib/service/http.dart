import 'package:dio/dio.dart';
import 'dart:async';

class HttpUtils {
  static Dio dio;
  // static const String API_PREFIX = 'http://bknds.jiajiale.site/migu';
  static const String API_PREFIX = 'http://localhost:3030/migu';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static get error => null;

  static Future<Map> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';
    Dio dio = createInstance();
    var result = {};

    print('请求地址: ' + API_PREFIX + url);

    try {
      Response response =
          await dio.request(url, data: data, options: Options(method: method));

      result = response.data;
    } on DioError catch (e) {
      print('请求出错: ' + e.toString());
    }

    return result;
  }

  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = Dio(options);
    }
    return dio;
  }

  static clear() {
    dio = null;
  }
}
