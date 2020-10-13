import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';

class DeviceFild {
  BuildContext context;
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
            obscureText: true,
          )
        ],
      ),
    );
  }

  Future<dynamic> connectio() async {
    return Wifi.connection('FLIA.RODRIGUEZ.BUELVAS', 'RAJUAL18').then((v) {
      return v;
    });
  }

  Future<Null> _getWifiName() async {
    int l = await Wifi.level;
    String wifiName = await Wifi.ssid;

    print(l);
    print(wifiName);
  }

  Future<dynamic> showMyDialog() {
    _getWifiName();
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
              title: Center(child: Text("Agrega Dispositivo...")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: FutureBuilder(
                  future: connectio(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      //print(snapshot.);
                      if (snapshot.data == WifiState.success) {
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _deviceField(
                                    customController, Icons.wifi, 'Red'),
                                _deviceField(
                                    customController, Icons.lock, 'Contraseña'),
                                _deviceField(customController,
                                    Icons.device_unknown, 'Nombre Dispositivo'),
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
}
