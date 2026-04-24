import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        // I know it's not safe to keep the API keys in code
        // but for test purposes it's fine :)
        'x-api-key': 'pub_01efac693497434ca1bb663c3796bd5d',
      },
    ),
  );
}
