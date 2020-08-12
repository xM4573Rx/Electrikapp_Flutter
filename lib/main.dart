import 'package:Electrikapp/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'FetoCardia',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage());
  }
}
