import 'package:Electrikapp/models/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('LOGIN'),
          onPressed: () {
            //Provider.of<LoginState>(context).login();
            Provider.of<LoginState>(context, listen: false).login();
          },
        ),
      ),
    );
  }
}
