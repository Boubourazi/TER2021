import 'package:flutter/material.dart';
import 'roundedBottom.dart';

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
          "${this.store["name"]} : ${this.currentPeople}",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Stack(
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
        ],
      ),
    );
  }
}
