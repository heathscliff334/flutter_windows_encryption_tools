import 'package:dio/dio.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: '',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
);
