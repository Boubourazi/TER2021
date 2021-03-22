import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StorePieChart extends StatelessWidget {
  const StorePieChart({
    Key key,
    @required this.store,
    @required this.currentPeople,
  }) : super(key: key);

  final store;
  final int currentPeople;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Future<void>.delayed(Duration(milliseconds: 10)),
        builder: (context, snapshot) {
          return PieChart(
            PieChartData(
              startDegreeOffset: -90,
              sectionsSpace: 5,
              centerSpaceRadius: double.infinity,
              borderData: FlBorderData(border: Border.all(width: 0)),
              sections: <PieChartSectionData>[
                PieChartSectionData(
                  radius: 50,
                  value: snapshot.connectionState == ConnectionState.done
                      ? 555
                      : 0,
                  color: Colors.green,
                  showTitle: true,
                ),
                PieChartSectionData(
                    radius: null,
                    value: this.store["maxPeopleCapacity"] -
                        this.currentPeople.toDouble(),
                    color: Colors.greenAccent,
                    showTitle: false),
              ],
            ),
            swapAnimationDuration: Duration(seconds: 1),
          );
        },
      ),
      width: 150,
      height: 150,
    );
  }
}
