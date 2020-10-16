import 'package:Electrikapp/models/login_state.dart';
import 'package:Electrikapp/pages/home.dart';
import 'package:Electrikapp/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi/wifi.dart';

void main() => runApp(MyApp());
String _wifiName = 'click button to get wifi ssid.';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ChangeNotifierProvider<LoginState>(
      create: (context) => LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FetoCardia',
        theme: ThemeData(primarySwatch: Colors.blue),
        /*home: HomePage()*/ /*LoginPage(
            title: 'Hola',
          ),*/
        routes: {
          '/': (BuildContext context) {
            //showMyDialog(context);
            var state = Provider.of<LoginState>(context, listen: true);
            if (state.loggedIn) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        },
      ),
    );
  }
}
