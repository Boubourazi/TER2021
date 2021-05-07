import 'package:app_ter/arretContainer.dart';
import 'package:app_ter/roundedBottom.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ArretDetailPage extends StatefulWidget {
  final dynamic arret;

  final List<dynamic> lignes;

  ArretDetailPage(this.arret, this.lignes);
  @override
  _ArretDetailPageState createState() => _ArretDetailPageState();
}

class _ArretDetailPageState extends State<ArretDetailPage> {
  Stream counter;
  int first;
  int second;
  int third;

  @override
  void initState() {
    first = Random().nextInt(3);
    second = Random().nextInt(3) + 4;
    third = Random().nextInt(7) + 10;
    counter = Stream.periodic(Duration(seconds: 5));
    counter.listen((event) {
      setState(() {
        first = first - 1;
        second = second - 1;
        third = third - 1;
      });
      if (first <= 0) {
        setState(() {
          first = second;
          second = third;
          third = Random().nextInt(7) + 13;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.widget.arret["description"]),
        backgroundColor: Color(0xFF0b75b0),
      ),
      body: Column(
        children: [
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
          Container(
            width: 500,
            height: 500,
            child: ListView.builder(
              itemCount: this.widget.lignes.length,
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(this.widget.lignes[itemIndex]["name"]),
                          ArretContainer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
