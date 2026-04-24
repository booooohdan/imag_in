import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStatusProvider extends ChangeNotifier {
  AppStatusProvider() {
    unawaited(initConnectivityAndAuth());
  }

  static const _tokenKey = 'auth_token';
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final _connectivity = Connectivity();

  bool _isInternetConnected = true;
  bool get isInternetConnected => _isInternetConnected;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  @override
  void dispose() {
    unawaited(_connectivitySubscription.cancel());
    super.dispose();
  }

  Future<void> initConnectivityAndAuth() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) async {
      _isInternetConnected = !result.contains(ConnectivityResult.none);

      if (_isInternetConnected) {
        await _initAuthentication();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> _initAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getString(_tokenKey) != null;
    _isLoading = false;
    notifyListeners();
  }

  void setLoggedIn({required bool value}) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _isLoggedIn = false;
    notifyListeners();
  }
}
