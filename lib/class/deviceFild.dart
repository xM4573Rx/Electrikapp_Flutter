import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:http/http.dart' as http;

class DeviceFild {
  BuildContext context;
  var network = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var costeValue = TextEditingController();
  var _data;

  DeviceFild(BuildContext context) {
    this.context = context;
  }

  Widget _deviceField(TextEditingController customController, IconData icon,
      String name, bool obscureText, TextInputType typeKey) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Crear Widget para campos
          new TextFormField(
            keyboardType: typeKey,
            //controller: password,
            decoration: new InputDecoration(icon: Icon(icon), labelText: name),
            autocorrect: false,
            obscureText: obscureText,
            style: TextStyle(fontSize: null), controller: customController,
          )
        ],
      ),
    );
  }

  Future<String> connection() async {
    var data1;
    while (data1 != 'ElectrikAppCentral') {
      var data =
          await Wifi.connection('ElectrikAppCentral', '12345678').then((v) {
        return v;
      });

      data1 = await _getWifiName();
    }
    return data1;
  }

  Future<String> _getWifiName() async {
    // int l = await Wifi.level;
    return Wifi.ssid.then((value) {
      // print(value);
      return value;
    });

    //print(l);
    //print(wifiName);
  }

  Future<List<WifiResult>> loadData() async {
    return Wifi.list('').then((list) {
      // print(list.iterator.);
      return list;
    });
  }

  Future<dynamic> configureFild() {
    // var password = TextEditingController();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    print('network.text.toString()');
                    Navigator.of(context).pop([
                      network.text.toString(),
                      password.text.toString(),
                      name.text.toString()
                    ]);
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
                  future: _getWifiName(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    network.text = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.data != '<unknown ssid>') {
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _deviceField(network, Icons.wifi, 'Red', false,
                                    TextInputType.text),
                                _deviceField(password, Icons.lock, 'Contraseña',
                                    true, TextInputType.text),
                                _deviceField(
                                    name,
                                    Icons.device_unknown,
                                    'Nombre Dispositivo',
                                    false,
                                    TextInputType.text),
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
                                Text('\nSin red WIFI disponible')
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  }));
        });
  }

  Future<dynamic> coste(num costeInicial, DatabaseReference ref) {
    // var password = TextEditingController();

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    print('network.text.toString()');
                    Navigator.of(context).pop(num.parse(costeValue.text));
                  },
                ),
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                )
              ],
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text("Costo KWH...")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: StreamBuilder<Event>(
                  stream: ref.onValue,
                  builder: (context, snapshat) {
                    if (snapshat.hasData) {
                      costeValue.text = snapshat.data.snapshot.value.toString();
                      return Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              _deviceField(
                                  costeValue,
                                  Icons.attach_money_rounded,
                                  'Valor en pesos',
                                  false,
                                  TextInputType.number),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }));
        });
  }

  Future<dynamic> networkLoading(var data) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    print('network.text.toString()');
                    Navigator.of(context)
                        .pop([network.text.toString(), name.text.toString()]);
                  },
                ),
              ],
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text("Agrega Dispositivo...")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: FutureBuilder(
                  future: sendData(data),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // network.text = snapshot.data;

                    if (snapshot.hasData == true) {
                      print(snapshot.data);

                      return Center(
                        heightFactor: 2,
                        child: Text('Bien..,'),
                      );
                    } else {
                      return Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }));
        });
  }

  Future<bool> sendData(var data) async {
    var d = await connection();
    //print(d);
    /* var listName = await loadData();
    print(listName);
    for (var i = 0; i < listName.length; i++) {
      print('${listName[i].ssid}');
    }
    WifiState _connect = await connection();
    print(_connect);*/

    String url = 'http://192.168.4.1/data.json';
    Map<String, String> headers = {"Content-type": "application/json"};

    String _body = json.encode(data);
    // String _body = data;
    await Future.delayed(Duration(seconds: 5), () {
      print('5 Segundo');
    });
    print('<<<<<<<<<<<<<<<<<<<<<<<<<');

    var response = await http.post(
      url,
      headers: headers,
      body: _body,
    );
    print('__________________________');
    int statusCode = response.statusCode;
    print(statusCode);
    String body = response.body;
    print(body);

    if (statusCode == 200) {
      //Navigator.of(context).pop([network.text.toString(), 'else']);
      return true;
    } else {
      return false;
      //Navigator.of(context).pop([network.text.toString(), 'if']);
    }
  }
}
