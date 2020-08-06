import 'dart:async';
import 'package:Electrikapp/Pages/central.dart';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _wifiName;
  List<WifiResult> ssidList = [];
  String ssid = '', password = '';
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _getWifiName();
    _timer = new Timer.periodic(
        const Duration(seconds: 5), (Timer t) => {loadData()});

    //_getWifiName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/name_sin_fondo.png'),
                height: 130,
              ),
              CircularProgressIndicator(
                strokeWidth: 4,
              )
            ],
          ),
        ),
      ),
    );
  }

  void loadData() async {
    Wifi.list('').then((list) {
      setState(() {
        ssidList = list;

        for (var i = 0; i < ssidList.length; i++) {
          print('${ssidList[i].ssid}');
          if (ssidList[i].ssid == 'ElectrikAppCentral') {
            connection('ElectrikAppCentral', '12345678')
                .then((value) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CentralPage();
                        },
                      ),
                    ));
          }
        }
      });
    });
  }

  Future<Null> _getWifiName() async {
    final SharedPreferences prefs = await _prefs;
    String wifiName = await Wifi.ssid;
    setState(() {
      _wifiName = wifiName;
      prefs.setString('Net', _wifiName);
    });
  }

  Future<Null> connection(String ssid, String password) async {
    Wifi.connection(ssid, password).then((v) {
      print(v);
      _timer.cancel();
    });
  }
}
