import 'package:Electrikapp/models/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

final String assetName = 'assets/images/ElectrikApp-Logo.svg';

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
              /*
              SvgPicture.string(
                'assets/images/ElectrikApp-Logo.svg',
                height: 100,
                width: 100,
              ),
              RaisedButton(
                child: Text('Hola..'),
                onPressed: () {
                  Provider.of<LoginState>(context, listen: false).login();
                },
              )
            */
              Padding(
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset(assetName,
                    width: 200, color: Colors.blueAccent),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: new InputDecoration(
                          icon: Icon(Icons.person), labelText: 'Correo'),
                      autocorrect: false,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          icon: Icon(Icons.person), labelText: 'Correo'),
                      autocorrect: false,
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
