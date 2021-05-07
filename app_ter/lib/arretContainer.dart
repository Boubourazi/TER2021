import 'package:flutter/material.dart';
import 'dart:math';

class ArretContainer extends StatefulWidget {
  @override
  _ArretContainerState createState() => _ArretContainerState();
}

class _ArretContainerState extends State<ArretContainer> {
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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(first.toString() + " min"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(second.toString() + " min"),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(third.toString() + " min"),
            ),
          ),
        ),
      ],
    );
  }
}
