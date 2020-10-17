import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:http/http.dart' as http;

class DeviceFild {
  BuildContext context;
  var network = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  DeviceFild(BuildContext context) {
    this.context = context;
  }

  Widget _deviceField(
      TextEditingController customController, IconData icon, String name) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Crear Widget para campos
          new TextFormField(
            //controller: password,
            decoration: new InputDecoration(icon: Icon(icon), labelText: name),
            autocorrect: false,
            obscureText: false,
            style: TextStyle(fontSize: null), controller: customController,
          )
        ],
      ),
    );
  }

  Future<WifiState> connection() async {
    // loadData();
    return Wifi.connection('ElectrikAppCentral', '12345678').then((v) {
      return v;
    });
  }

  Future<String> _getWifiName() async {
    // int l = await Wifi.level;
    return Wifi.ssid.then((value) {
      return value;
    });

    //print(l);
    //print(wifiName);
  }

  void loadData() async {
    Wifi.list('').then((list) {
      print(list);
    });
  }

  Future<dynamic> showMyDialog() {
    // var password = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    print('network.text.toString()');
                    Navigator.of(context)
                        .pop([network.text.toString(), name.text.toString()]);
                  },
                ),
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop('Cancelar');
                  },
                )
              ],
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text("Agrega Dispositivo...")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: FutureBuilder(
                  future: connection(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    network.text = 'Hola'; //snapshot.data.toString();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      /*'<unknown ssid>'*/
                      print(snapshot.data);
                      if (snapshot.data != WifiState.success) {
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _deviceField(network, Icons.wifi, 'Red'),
                                _deviceField(
                                    password, Icons.lock, 'Contraseña'),
                                _deviceField(name, Icons.device_unknown,
                                    'Nombre Dispositivo'),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 100,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.sentiment_dissatisfied),
                                Text('Dispositivo no valido para configurar')
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  }));
        });
  }

  Future<dynamic> showLoading() {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    Navigator.of(context).pop(['1', '2']);
                  },
                ),
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop('Cancelar');
                  },
                )
              ],
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text("Agregando...")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: FutureBuilder(
                  future: _getWifiName(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Center(
                      heightFactor: 2,
                      child: CircularProgressIndicator(),
                    );
                  }));
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
            //_createDB();
            return null;
          },
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return null;
          },
        ),
      );
    }
  }
}
