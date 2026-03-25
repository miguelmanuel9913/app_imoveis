import 'dart:io';
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
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5264/';
    }
    return 'http://localhost:5264/';
  }

  void setBearerToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
