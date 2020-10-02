import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key, this.onLoginSuccess}) : super(key: key);
  final Function onLoginSuccess;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('LOGIN'),
          onPressed: () {
            onLoginSuccess();
          },
        ),
      ),
    );
  }
}
