import 'package:Electrikapp/class/graph.dart';
import 'package:Electrikapp/models/dataFetoCardia.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewWidget extends StatefulWidget {
  final Map<dynamic, dynamic> data;

  const ViewWidget({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ViewWidget();
}

class _ViewWidget extends State<ViewWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: Column(
      children: <Widget>[
        _expenses(),
        /*_graph()*/ CircularProgressIndicator(),
        _list()
      ],
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
    var lst = new List<double>(5);
    lst[0] = 12;
    final double y = widget.data['1234567']['userId'];
    final double y1 = widget.data['otro']['userId'];
    final double y2 = widget.data['otromas']['userId'];
    print(y);
    lst[1] = y;
    lst[2] = 11;
    lst[3] = y1;
    lst[4] = y2;
    return Container(
      height: 150.0,
      width: 300.0,
      margin: EdgeInsets.all(1),
      child: GraphWidget(
        data: lst,
      ) /*CircularProgressIndicator(
        strokeWidth: 20,
        value: 0.9,
      ) GaugeChart.withSampleData() */
      ,
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
      itemCount: widget.data.keys.length,
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
