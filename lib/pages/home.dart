import 'package:Electrikapp/pages/view.dart';
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
  DatabaseReference dBRef =
      FirebaseDatabase.instance.reference().child('dataMedico');

//  StreamSubscription<Event> _onChildAdded;
//  StreamSubscription<Event> _onChildChanged;
//  StreamSubscription<Event> _onChildMoved;
//  StreamSubscription<Event> _onChildRemoved;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
            showMyDialog(context).then((value) => {print(value)});
          }),
      body: _body(),
    );
  }

  Widget _deviceField(
      TextEditingController customController, IconData icon, String name) {
    ///String name = 'Hola Mundo';
    return Container(
      margin: EdgeInsets.all(8),
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

  Future<String> showMyDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                MaterialButton(
                  elevation: 0.5,
                  child: Text('Sublie'),
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
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Center(
                  heightFactor: 2,
                  child: CircularProgressIndicator(),
                );
              })
              /*Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _deviceField(customController, Icons.wifi, 'Red'),
                      _deviceField(customController, Icons.device_unknown,
                          'Dispositivo'),
                      _deviceField(customController, Icons.group, 'Grupo'),
                    ],
                  ),
                ),
              )*/
              );
        });
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
          // _pageItem('Vista Tres', 2),
          // _pageItem('Vista Cuatro', 3),
          // _pageItem('Vista Cinco', 4),
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
