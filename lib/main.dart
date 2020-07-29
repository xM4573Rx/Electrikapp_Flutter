import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electrikapp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
        ),
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _wifiName = 'click button to get wifi ssid.';
  int level = 0;
  String _ip = 'click button to get ip.';
  List<WifiResult> ssidList = [];
  String ssid = '', password = '';

  @override
  void initState() {
    super.initState();
    loadData();
    _getWifiName();
  }

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return Text('wordPair.asPascalCase');
  }

  void loadData() async {
    Wifi.list('').then((list) {
      setState(() {
        ssidList = list;

        for (var i = 0; i < ssidList.length; i++) {
          print('${ssidList[i].ssid}');
        }
      });
    });
  }

  Future<Null> _getWifiName() async {
    int l = await Wifi.level;
    String wifiName = await Wifi.ssid;
    //print('$wifiName');
    setState(() {
      level = l;
      _wifiName = wifiName;
      print('$_wifiName');
    });
  }
}
