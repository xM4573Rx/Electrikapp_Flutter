import 'package:Electrikapp/pages/home.dart';
import 'package:Electrikapp/pages/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FetoCardia',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage()/*LoginPage(
          title: 'Hola',
        )*/);
  }
}
