import 'dart:async';

import 'package:Electrikapp/class/circle.dart';
import 'package:Electrikapp/class/graph.dart';
import 'package:Electrikapp/pages/view.dart';
import 'package:Electrikapp/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controler PageView
  PageController _controller;
  int currentPage = 3;
  final DBRef = FirebaseDatabase.instance.reference().child('path');
  StreamSubscription<Event> _onChildAdded;
  StreamSubscription<Event> _onChildChanged;
  StreamSubscription<Event> _onChildMoved;
  StreamSubscription<Event> _onChildRemoved;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onChildChanged = DBRef.onChildChanged.listen((event) {});
    _controller =
        PageController(initialPage: currentPage, viewportFraction: 0.4);
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(icon)),
      onTap: () {},
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
            _bottomAction(Icons.history),
            _bottomAction(Icons.alarm),
            SizedBox(
              width: 48.0,
            ),
            _bottomAction(Icons.file_download),
            _bottomAction(Icons.settings),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            writeData();
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
            builder: (BuildContext context, AsyncSnapshot<Event> data) {
          return ViewWidget();
        })
      ],
    ));
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
          // _pageItem('Vista Tres', 2),
          // _pageItem('Vista Cuatro', 3),
          // _pageItem('Vista Cinco', 4),
        ],
      ),
    );
  }

  void writeData() {
    //DBRef.onChildAdded
  }
}
