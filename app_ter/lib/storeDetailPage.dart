import 'package:flutter/material.dart';

class StoreDetailPage extends StatelessWidget {
  final dynamic store;

  StoreDetailPage(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0b75b0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(this.store["name"]),
      ),
    );
  }
}
