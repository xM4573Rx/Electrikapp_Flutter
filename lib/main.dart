import 'package:Electrikapp/models/login_state.dart';
import 'package:Electrikapp/pages/home.dart';
import 'package:Electrikapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<LoginState>(
      builder: (BuildContext context) => LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FetoCardia',
        theme: ThemeData(primarySwatch: Colors.blue),
        /*home: HomePage()*/ /*LoginPage(
            title: 'Hola',
          ),*/
        routes: {
          '/': (BuildContext contex) {
            if (_loggedIn) {
              return HomePage();
            } else {
              return LoginPage(
                onLoginSuccess: () {
                  setState(() {
                    _loggedIn = true;
                  });
                },
              );
            }
          },
        },
      ),
    );
  }
}
