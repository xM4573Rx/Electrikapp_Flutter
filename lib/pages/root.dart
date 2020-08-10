import 'package:Electrikapp/pages/home.dart';
import 'package:Electrikapp/pages/login.dart';
import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.authFireBase}) : super(key: key);
  final AuthFireBase authFireBase;
  @override
  State<StatefulWidget> createState() => new RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState() {
    // TODO: implement initState
    print('Inicia.....');
    widget.authFireBase.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('Case 0');
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        print('Case 1');
        return new LoginPage(
          title: 'Login',
          auth: widget.authFireBase,
          onSignIn: () => updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        print('Case 2');
        return new HomePage(
          onSignIn: () => updateAuthStatus(AuthStatus.notSignedIn),
          authFireBase: widget.authFireBase,
        );
    }
  }

  void updateAuthStatus(AuthStatus auth) {
    setState(() {
      authStatus = auth;
    });
  }
}
