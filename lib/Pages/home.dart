import 'package:flutter/material.dart';
import 'circle_progress.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _allEnergy;
  var _power;
  var _costKwh;
  String _groupName;
  String _allEnergyText;
  String _powerText;
  String _pay;
  String _path = 'Groups/';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final DatabaseReference _reference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _loadGroupName();
    _readDB();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Electrikapp'),
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_tonos.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*SizedBox(
                  height: 20.0,
                ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_allEnergyText',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('$_powerText', style: TextStyle(fontSize: 18))
                  ],
                ),
              ),
              /*SizedBox(
                  height: 60,
                ),*/
              SizedBox(
                child: CustomPaint(
                  foregroundPainter: RadialPainter(
                      bgColor: Colors.grey[200],
                      lineColor: Colors.blue,
                      percent: 0.6,
                      // lineColor: getColor(context, percent),
                      // percent: percent,
                      width: 15.0),
                  child: Center(
                    child: Text(
                      '$_pay',
                      // '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                height: 300.0,
                width: 300.0,
              ),
              Text(''),
            ],
          ),
        ),
      ),
    );
  }

  void _loadGroupName() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _groupName = prefs.getString('Group');
    });
  }

  void _readDB() {
    _reference
        .child(_path)
        .child('All')
        .child('Energy')
        .onValue
        .listen((event) {
      _allEnergy = event.snapshot;
      print(_allEnergy.value);
      _allEnergyText = _allEnergy.value.toString() + ' kWh';
      print(_allEnergyText);
    });
    _reference.child(_path).child('All').child('Power').onValue.listen((event) {
      _power = event.snapshot;
      print(_power.value);
      _powerText = _power.value.toString() + ' kWh';
      print(_powerText);
    });
    _reference
        .child(_path)
        .child('Settings')
        .child('Cost')
        .onValue
        .listen((event) {
      _costKwh = event.snapshot;
      print(_costKwh.value);
      _pay = ((_costKwh.value) * (_allEnergy.value)).toString();
      print(_pay);
    });
  }
}
