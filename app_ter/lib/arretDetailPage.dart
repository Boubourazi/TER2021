import 'package:flutter/material.dart';
import 'roundedBottom.dart';
import 'storeBarChart.dart';
import 'storeDialChart.dart';

class StoreDetailPage extends StatefulWidget {
  final dynamic store;
  final int currentPeople;

  StoreDetailPage(this.store, this.currentPeople);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  bool favorite;

  @override
  void initState() {
    super.initState();
    this.favorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("oui"),
      ),
    );
  }
}
