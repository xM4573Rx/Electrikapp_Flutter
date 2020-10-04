import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  void login() async {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
