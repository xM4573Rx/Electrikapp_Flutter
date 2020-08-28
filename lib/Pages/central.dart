import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi/wifi.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

import 'groups.dart';
import 'groups_two.dart';

class CentralPage extends StatefulWidget {
  @override
  _CentralPageState createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  bool _showPass = true;
  String _net;
  String _pass;
  String _name;
  String _userName;
  String _groupName;
  String _path = 'Groups/';
  var _data;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _netController = new TextEditingController();
  final DatabaseReference _reference = FirebaseDatabase.instance.reference();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    _loadNetName();
    _loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Crear nuevo grupo'),
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_tonos.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildNet(),
                SizedBox(
                  height: 10,
                ),
                _buildPass(),
                SizedBox(
                  height: 10,
                ),
                _buildName(),
                SizedBox(
                  height: 15,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Crear',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();

                        _data = {
                          'Red': _net,
                          'Pass': _pass,
                          'Name': _groupName
                        };

                        sendData(_data);
                        //connection('ssid', 'password');
                      }),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildNet() {
    return TextFormField(
      controller: _netController,
      readOnly: true,
      //enabled: false,
      decoration: InputDecoration(
          labelText: 'Red',
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      onSaved: (newValue) {
        _net = newValue;
      },
    );
  }

  Widget _buildPass() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
          labelText: 'Contraseña',
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _showPass = !_showPass;
              });
            },
            child: Icon(_showPass ? Icons.visibility : Icons.visibility_off),
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      obscureText: _showPass,
      onSaved: (newValue) {
        _pass = newValue;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          hintText: 'Nombre del grupo (ej: Casa, Oficina)',
          labelText: 'Nombre',
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Se requiere un nombre válido';
        }
        return null;
      },
      onSaved: (newValue) {
        _name = newValue;
        _groupName = '$_name' + '_' + '$_userName';
        _groupName = _groupName.replaceAll(RegExp(' '), '_');

        _saveGroupName(_name, _userName, _groupName);
      },
    );
  }

  void _loadNetName() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _netController.text = prefs.getString('Net');
    });
  }

  void _loadUserName() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _userName = prefs.getString('Name');
      print(_userName);
    });
  }

  void _saveGroupName(String name, String user, String group) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString('Group', group);
      prefs.setString('Device', name);
    });
  }

  Future<Null> connection(String ssid, String password) async {
    Wifi.connection(ssid, password).then((v) {
      print(v);
    });
  }

  Future<void> sendData(var data) async {
    String url = 'http://192.168.4.1/data.json';
    Map<String, String> headers = {"Content-type": "application/json"};

    String _body = json.encode(data);
    // String _body = data;

    var response = await http.post(url, headers: headers, body: _body);

    int statusCode = response.statusCode;
    print(statusCode);
    String body = response.body;
    print(body);

    if (statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            _createDB();
            return GroupsTwoPage();
          },
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return GroupsPage();
          },
        ),
      );
    }
  }

  void _createDB() {
    _reference
        .child(_path)
        .child(_groupName)
        .child('All')
        .set({'Name': 'Oficina', 'Energy': 0, 'Power': 0});
    _reference
        .child(_path)
        .child(_groupName)
        .child('Settings')
        .set({'Date': 0, 'Cost': 0, 'Projection': 0});
  }
}
