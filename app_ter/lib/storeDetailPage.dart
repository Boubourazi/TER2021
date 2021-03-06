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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0b75b0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(this.favorite ? Icons.star : Icons.star_border),
            onPressed: () {
              this.setState(() {
                this.favorite = !this.favorite;
              });
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          "${this.widget.store["name"]}",
          style: Theme.of(context).textTheme.headline2,
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: StoreDialChart(
                    store: widget.store, currentPeople: widget.currentPeople),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      "Adresse",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                        "${this.widget.store["address"]}, ${this.widget.store["city"]}"),
                    Spacer(
                      flex: 5,
                    ),
                    Text(
                      "T??l??phone",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text("${this.widget.store["phone"] ?? "Non renseign??"}"),
                  ],
                ),
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: StoreBarChart(15, this.widget.store),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
