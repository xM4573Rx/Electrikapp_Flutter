import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';

class DeviceFild extends StatefulWidget {
  DeviceFild({Key key}) : super(key: key);

  @override
  _DeviceFildState createState() => _DeviceFildState();
}

class _DeviceFildState extends State<DeviceFild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
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

  Future<WifiState> connection() async {
    return Wifi.connection('DTVNET_00D808', '0bhtp9hl').then((v) {
      return WifiState.success;
    });
  }

  Future<Widget> showMyDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                MaterialButton(
                  elevation: 0.5,
                  child: Text('Agregar'),
                  onPressed: () {
                    Navigator.of(context).pop(customController.text.toString());
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(),
                      );
                    } else {
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
        }).then((value) => print(value));
    return null;
  }
}
