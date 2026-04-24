import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:imag_in/core/services/api_client.dart';
import 'package:imag_in/core/services/app_status_provider.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/features/authentication/models/auth_request.dart';
import 'package:imag_in/features/authentication/models/auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static const _tokenKey = 'auth_token';
  late AppStatusProvider _appStatusProvider;

  ConsumerState? _state;
  ConsumerState? get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void updateAppStatusProvider(AppStatusProvider provider) =>
      _appStatusProvider = provider;

  Future<void> login(String email, String password) async {
    _state = ConsumerState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiClient.dio.post<Map<String, dynamic>>(
        '/login',
        data: AuthRequest(email: email, password: password).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data!);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, authResponse.token);

      _appStatusProvider.setLoggedIn(value: true);
      _state = ConsumerState.success;
      notifyListeners();
    } on DioException catch (error) {
      log('❌ login error: $error');
      _errorMessage = error.response?.statusCode == 400
          ? 'Invalid credentials'
          : 'Something went wrong';
      _state = ConsumerState.error;
      notifyListeners();
    }
  }
}
