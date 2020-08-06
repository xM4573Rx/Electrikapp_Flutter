import 'package:flutter/material.dart';

class CentralPage extends StatefulWidget {
  @override
  _CentralPageState createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  String _net;
  String _pass;
  String _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Crear nuevo grupo'),
        ),
        body: Container(
            margin: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildNet(),
                  SizedBox(
                    height: 5,
                  ),
                  _buildPass(),
                  SizedBox(
                    height: 5,
                  ),
                  _buildName(),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                      child: Text(
                        'Enviar',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        print(_net);
                        print(_pass);
                        print(_name);
                      })
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildNet() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Red',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      onSaved: (newValue) {
        _net = newValue;
      },
    );
  }

  Widget _buildPass() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Contraseña',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      onSaved: (newValue) {
        _pass = newValue;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Nombre',
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
      },
    );
  }
}
