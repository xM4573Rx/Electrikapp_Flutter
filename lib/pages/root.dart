import 'package:Electrikapp/pages/home.dart';
import 'package:Electrikapp/pages/login.dart';
import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }

  void updateAuthStatus(AuthStatus auth) {
    setState(() {
      authStatus = auth;
    });
  }
}
/*
  return new FutureBuilder(
          future: AuthFireBase().currentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.transparent,
                strokeWidth: 10,
              ));
            } else {
              return new LoginPage(
                title: 'Login',
                auth: widget.authFireBase,
                onSignIn: () => updateAuthStatus(AuthStatus.signedIn),
              );
            }
          },
        );
 */
