import 'package:Electrikapp/class/deviceFild.dart';
import 'package:Electrikapp/models/login_state.dart';
import 'package:Electrikapp/pages/view.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi/wifi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controler PageView
  PageController _controller;
  int currentPage = 3;
  DatabaseReference dBRef =
      FirebaseDatabase.instance.reference().child('dataMedico');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =
        PageController(initialPage: currentPage, viewportFraction: 0.4);
  }

  Widget _bottomAction(IconData icon, Function callback) {
    return InkWell(
      child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(icon)),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(Icons.graphic_eq_rounded, () {}),
            _bottomAction(Icons.alarm, () {}),
            SizedBox(
              width: 48.0,
            ),
            _bottomAction(Icons.file_download, () {}),
            _bottomAction(Icons.settings, () {
              Provider.of<LoginState>(context, listen: false).logout();
            }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print(DeviceFild(context)
                .showMyDialog()
                .then((value) => print(value[0])));

            // showMyDialog(context);
          }),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Column(
      children: <Widget>[
        _selector(),
        StreamBuilder<Event>(
            stream: dBRef.onValue,
            builder: (context, snapshat) {
              if (snapshat.hasData) {
                var resq = snapshat.data.snapshot;

                Map<dynamic, dynamic> values = resq.value;

                return ViewWidget(
                  data: values,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            })
      ],
    ));
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem('Vista Pesos', 0),
          _pageItem('Vista KWH', 1),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    var _alignmet;

    final selected = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey);

    final unselected = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey.withOpacity(0.4));

    if (position == currentPage) {
      _alignmet = Alignment.center;
    } else if (position > currentPage) {
      _alignmet = Alignment.centerRight;
    } else {
      _alignmet = Alignment.centerLeft;
    }

    return Align(
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
      alignment: _alignmet,
    );
  }
}
