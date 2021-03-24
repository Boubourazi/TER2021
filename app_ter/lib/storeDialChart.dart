import 'package:flutter/material.dart';

class StoreDialChart extends StatefulWidget {
  final dynamic store;
  final int currentPeople;

  StoreDialChart({
    Key key,
    @required this.store,
    @required this.currentPeople,
  }) : super(key: key);

  @override
  _StoreDialChartState createState() => _StoreDialChartState();
}

class _StoreDialChartState extends State<StoreDialChart> {
  bool animationDone = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future<void>.delayed(Duration(milliseconds: 200))
          .then((value) => this.setState(() {
                this.animationDone = true;
              })),
      builder: (context, snapshot) {
        return AnimatedContainer(
          duration: Duration(seconds: 1),
          width: 150,
          height: 150,
          color: Colors.blue,
          child: Stack(
            children: <Widget>[],
          ),
        );
      },
    );
  }
}
