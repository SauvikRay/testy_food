import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: 'https://api.example.com', // Replace with real API
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  )) {
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Dio get dio => _dio;
}
