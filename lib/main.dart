import 'package:flutter/material.dart';
import 'package:Electrikapp/Pages/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electrikapp',
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Electrikapp'),
        ),*/
        body: Center(
          child: RegisterPage(),
        ),
      ),
    );
  }
}

/*class LoginPage extends StatefulWidget {
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton.icon(
            onPressed: () {},
            textColor: Colors.white,
            icon: Icon(Icons.g_translate),
            label: const Text('Acceder con Google'),
            color: Colors.red,
          ),
        ],
      ),
    );
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
      //print('$_wifiName');
    });
  }
}*/
