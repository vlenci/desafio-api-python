import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  void setTokens({required String access, required String refresh}) {
    _accessToken = access;
    _refreshToken = refresh;
    notifyListeners();
  }

  void updateAccessToken(String newAccess) {
    _accessToken = newAccess;
    notifyListeners();
  }

  void logout() {
    _accessToken = '';
    _refreshToken = '';
    notifyListeners();
  }

  bool get isAuthenticated => _accessToken.isNotEmpty;
}
