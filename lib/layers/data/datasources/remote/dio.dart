import 'dart:io';
import 'package:biolo_app/core/inject/config/const.dart';
import 'package:dio/dio.dart';


class DioUrls {
  final Dio dio;

  DioUrls({String? baseUrl, String? bearerToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? _defaultBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 20),
            headers: {
              'accept': '*/*',
              if (bearerToken != null && bearerToken.isNotEmpty)
                'Authorization': 'Bearer $bearerToken',
            },
          ),
        );

  static String get _defaultBaseUrl {
    return ConstApi.apiCosnt;
  }

  void setBearerToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
