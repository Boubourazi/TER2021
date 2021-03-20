import 'package:flutter/material.dart';
import 'roundedBottom.dart';
import 'package:fl_chart/fl_chart.dart';

class StoreDetailPage extends StatelessWidget {
  final dynamic store;
  final int currentPeople;

  StoreDetailPage(this.store, this.currentPeople);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0b75b0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "${this.store["name"]}",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            clipper: RoundedBottom(),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0b75b0),
                    Color(0xFF0eaddc),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                strokeWidth: 15,
                value: 0.2,
                backgroundColor: Colors.greenAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Container(
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: double.infinity,
                  borderData:
                      FlBorderData(border: Border.all(color: Colors.white)),
                  sections: <PieChartSectionData>[
                    PieChartSectionData(
                        value: this.currentPeople.toDouble(),
                        color: Colors.green),
                    PieChartSectionData(
                        value: this.store["maxPeopleCapacity"] -
                            this.currentPeople.toDouble(),
                        color: Colors.greenAccent,
                        showTitle: false),
                  ],
                ),
              ),
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
