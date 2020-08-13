import 'package:Electrikapp/class/graph.dart';
import 'package:Electrikapp/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Column(
      children: <Widget>[_selector(), _expenses(), _graph(), _list()],
    ));
  }

  Widget _selector() => Container();
  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          '\$2345.5',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
        ),
        Text(
          'Total Ganancias',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 250.0,
      child: GraphWidget(),
    );
  }

  Widget _item(IconData icon, String name, int porcent, double value) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          icon,
          size: 32.0,
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(
          '$porcent% of expenses',
          style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
        ),
        trailing: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '\$$value',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
        child: ListView.separated(
      itemCount: 14,
      itemBuilder: (context, index) => RaisedButton(
        onPressed: () {},
        child: _item(Icons.ac_unit, 'Agua', 20, 23),
      )
      /*_item(Icons.phone_android, 'Shopping', 14, 145.12)*/,
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.blueAccent.withOpacity(0.15),
          height: 8,
        );
      },
    ));
  }
}
