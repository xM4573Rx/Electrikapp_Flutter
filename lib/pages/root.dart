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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      //appBar: new AppBar(title: new Text('Espera...')),
      backgroundColor: Colors.white,
      body: new FutureBuilder(
          future: AuthFireBase().currentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return HomePage();
            }
          }),
    );
    /*switch (authStatus) {
      case AuthStatus.notSignedIn:
        print('Sin Iniciae.....');
        return new LoginPage(
          title: 'Login',
          auth: widget.authFireBase,
          onSignIn: () => updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        print('Iniciado....');
        return new HomePage(
          onSignIn: () => updateAuthStatus(AuthStatus.notSignedIn),
          authFireBase: widget.authFireBase,
        );
    }*/
  }

/*
return new FutureBuilder(
      future: AuthFireBase().currentUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return HomePage();
        }
      },
    );
*/
/*
return new FutureBuilder(
      future: AuthFireBase().currentUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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

/*
return new FutureBuilder(
      future: AuthFireBase().currentUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return new HomePage(
          onSignIn: () => updateAuthStatus(AuthStatus.notSignedIn),
          authFireBase: widget.authFireBase,
        );
        }
      },
    );
*/

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
