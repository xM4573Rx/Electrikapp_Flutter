import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupsTwoPage extends StatefulWidget {
  @override
  _GroupsTwoPageState createState() => _GroupsTwoPageState();
}

class _GroupsTwoPageState extends State<GroupsTwoPage> {
  String _deviceName;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadDeviceName();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Grupos'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                    margin: EdgeInsets.all(12),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            '$_deviceName',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadDeviceName() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _deviceName = prefs.getString('Device');
      print(_deviceName);
    });
  }
}
