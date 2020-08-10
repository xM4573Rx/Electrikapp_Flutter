import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CentralPage extends StatefulWidget {
  @override
  _CentralPageState createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  String _net;
  String _pass;
  String _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _netController = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    _loadNetName();
  }

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
                    height: 15,
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
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
                          print(_net);
                          print(_pass);
                          print(_name);
                        }),
                  )
                ],
              ),
            )),
      ),
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
      decoration: InputDecoration(
          labelText: 'Contraseña',
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
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
      },
    );
  }

  void _loadNetName() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _netController.text = prefs.getString('Net');
    });
  }
}
