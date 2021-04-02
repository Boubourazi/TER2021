import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
    return Container(
      width: 180,
      height: 150,
      child: SfRadialGauge(
        animationDuration: 2500,
        enableLoadingAnimation: true,
        title: GaugeTitle(
            text: 'Occupation',
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(
            showTicks: false,
            showLabels: false,
            canScaleToFit: true,
            radiusFactor: 1,
            startAngle: 180,
            endAngle: 0,
            minimum: 0,
            maximum: this.widget.store["maxPeopleCapacity"].toDouble(),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue:
                    this.widget.store["maxPeopleCapacity"].toDouble() * 0.33,
                color: Color(0xff5ed12e),
                startWidth: 50,
                endWidth: 50,
              ),
              GaugeRange(
                startValue:
                    this.widget.store["maxPeopleCapacity"].toDouble() * 0.33,
                endValue:
                    this.widget.store["maxPeopleCapacity"].toDouble() * 0.66,
                color: Color(0xffffb95d),
                startWidth: 50,
                endWidth: 50,
              ),
              GaugeRange(
                startValue:
                    this.widget.store["maxPeopleCapacity"].toDouble() * 0.66,
                endValue: this.widget.store["maxPeopleCapacity"].toDouble(),
                color: Color(0xfffe3737),
                startWidth: 50,
                endWidth: 50,
              )
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                enableAnimation: true,
                value: this.widget.currentPeople.toDouble(),
                lengthUnit: GaugeSizeUnit.logicalPixel,
                needleLength: 50,
                needleStartWidth: 0,
                needleEndWidth: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
