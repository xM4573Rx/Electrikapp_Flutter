import 'package:flutter/material.dart';

class ViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewWidget();
}

class _ViewWidget extends State<ViewWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: Column(
      children: <Widget>[_expenses(), _graph(), _list()],
    ));
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          '\$2345.5',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
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
      height: 100.0,
      width: 100.0,
      margin: EdgeInsets.all(20),
      child: CircularProgressIndicator(
        strokeWidth: 20,
        value: 0.9,
      ) /*GaugeChart.withSampleData() GraphWidget()*/,
    );
  }

  Widget _item(IconData icon, String name, int porcent, double value) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30.0,
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
            padding: const EdgeInsets.all(4),
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
      itemCount: 6,
      itemBuilder: (context, index) => Card(
        child: MaterialButton(
          onPressed: () {},
          child: _item(Icons.ac_unit, 'Agua', 20, 23),
        ),
      ),
      /*_item(Icons.phone_android, 'Shopping', 14, 145.12)*/
      separatorBuilder: /*(BuildContext context, int index) => Divider(),*/
          (context, index) {
        return Container(
          color: Colors.blueAccent.withOpacity(0.15),
          height: 1,
        );
      },
    ));
  }
}
