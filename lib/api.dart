import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Response> postMedia(String url, dynamic args) async {
  try {
    Dio dio = Dio();
    //final userStorage = GetStorage();

    if (true) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 200,
      ));
    }
    Response response = await dio.post(
      url,
      data: FormData.fromMap(args),
      options: Options(
        headers: {},
      ),
    );

    return response;
  } on DioError catch (e) {
    throw e;
  }
}

Future<Response> postNormal(String url, dynamic args) async {
  try {
    Dio dio = Dio();
    //final userStorage = GetStorage();

    if (true) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 200,
      ));
    }
    Response response = await dio.post(
      url,
      data: jsonEncode(args),
      options: Options(
        headers: {},
      ),
    );

    return response;
  } on DioError catch (e) {
    throw e;
  }
}

Future<Response> getUrl(String url) async {
  try {
    Dio dio = Dio();
    //final userStorage = GetStorage();

    if (true) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 200,
      ));
    }
    Response response = await dio.get(
      url,
      options: Options(
        headers: {},
      ),
    );

    return response;
  } on DioError catch (e) {
    throw e;
  }
}