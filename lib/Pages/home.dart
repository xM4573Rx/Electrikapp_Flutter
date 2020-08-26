import 'package:flutter/material.dart';
import 'circle_progress.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Electrikapp'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
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
                        'Value',
                        // '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
