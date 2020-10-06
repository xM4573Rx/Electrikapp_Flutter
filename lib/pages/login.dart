import 'package:Electrikapp/models/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

final String logoElectrikApp = 'assets/images/ElectrikApp-Logo.svg';
final String logoFacebook = 'assets/images/Logo-Facebook.svg';
final String logoGoogle = 'assets/images/Logo-Google.svg';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginState>(
          builder: (context, value, child) {
            if (value.loading) {
              return CircularProgressIndicator();
            } else {
              return child;
            }
          },
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(logoElectrikApp, width: 150),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: formLogin(context),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {},
                      child: Text('Usuario Nuevo?'),
                      color: Colors.blueAccent.withOpacity(0.2),
                    ),
                    // SvgPicture.asset(logoFacebook, width: 40),
                    FlatButton(
                      child: SvgPicture.asset(logoGoogle, width: 40),
                      onPressed: () {
                        Provider.of<LoginState>(context, listen: false).login();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formLogin(BuildContext context) {
    return Form(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: new InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Correo'),
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: new InputDecoration(
                      icon: Icon(Icons.lock), labelText: 'Contraseña'),
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                  color: Colors.white,
                  child: Text('Ingresar'),
                  onPressed: () {
                    // Provider.of<LoginState>(context, listen: false).login();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);
  final String title;
  final AuthFireBase auth;
  final VoidCallback onSignIn;

  LoginPageState createState() => new LoginPageState();
}

enum FormType { login, register }

class LoginPageState extends State<LoginPage> {
  final formkey = new GlobalKey<FormState>();
  FormType formType = FormType.login;
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formkey,
          child: new Column(
            children: formLogin(),
          ),
        ),
      ),
    );
  }

  List<Widget> formLogin() {
    return [
      padded(
          child: new TextFormField(
        controller: email,
        decoration:
            new InputDecoration(icon: Icon(Icons.person), labelText: 'Correo'),
        autocorrect: false,
      )),
      padded(
          child: new TextFormField(
        controller: password,
        decoration: new InputDecoration(
            icon: Icon(Icons.lock), labelText: 'Contraseña'),
        autocorrect: false,
        obscureText: true,
      )),
      new Column(
        children: buttonWidgets(),
      )
    ];
  }

  List<Widget> buttonWidgets() {
    switch (formType) {
      case FormType.login:
        return [
          styleButton('Iniciar Sesion', validateSubmit),
          new FlatButton(
              child: Icon(
                  Icons.person_add), //new Text("No tienes cuenta? Registrate"),
              onPressed: () => {updateFormType(FormType.register)})
        ];
      case FormType.register:
        return [
          styleButton('Crear cuenta', validateSubmit),
          new FlatButton(
              child: Icon(Icons.person), //new Text("Iniciar sesion"),
              onPressed: () => updateFormType(FormType.login))
        ];
    }
  }

  void updateFormType(FormType form) {
    formkey.currentState.reset();
    setState(() {
      formType = form;
    });
  }

  void validateSubmit() {
    (formType == FormType.login)
        ? widget.auth.signIn(email.text, password.text)
        : widget.auth.creteUser(email.text, password.text);
    widget.onSignIn();
  }

  Widget styleButton(String text, VoidCallback onPressed) {
    return new RaisedButton(
      onPressed: onPressed,
      color: Colors.blue,
      child: new Text(text),
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
*/
