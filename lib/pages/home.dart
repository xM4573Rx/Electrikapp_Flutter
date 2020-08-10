import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onSignIn, this.authFireBase});
  final VoidCallback onSignIn;
  final AuthFireBase authFireBase;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showMyDialog(context).then((value) => {print(value)});
            } /*showMyDialog(context)*/),
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: sigOut,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )) //new Text('Cerrar Sesion'))
          ],
          title: new Text('Home'),
        ));
  }

  void sigOut() {
    print('Sali....');
    authFireBase.signOut();
    onSignIn();
  }

  Future<String> showMyDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Dispositivo'),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 0.5,
                child: Text('Sublie'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }
}

/* => AlertDialog(
        title: Text('Hola Mundo'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              TextFormField(),
              Text('This is a demo alert dialog.'),
              TextFormField(),
              Text('This is a demo alert dialog.'),
              TextFormField(),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Desaprove'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),*/
/* barrierDismissible: false*/
