import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StoreBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return (Container(
          child: Center(child: Text("WIP")),
          width: 400,
          height: 150,
          color: Colors.blue,
        ));
      },
    );
  }
}
