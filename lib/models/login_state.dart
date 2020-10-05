import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  bool _loading = false;

  bool get loggedIn => _loggedIn;
  bool get loading => _loading;

  void login() async {
    _loading = true;
    notifyListeners();

    var user = await AuthFireBase().signInGoogle();
    _loading = false;
    if (user != null) {
      _loggedIn = true;

      notifyListeners();
    } else {
      _loggedIn = false;
      notifyListeners();
    }
    print(user.user.displayName);
  }

  void logout() {
    AuthFireBase().signOut();
    _loggedIn = false;
    notifyListeners();
  }
}
