import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'storeDetailPage.dart';
import 'storeMap.dart';

class ArretList extends StatefulWidget {
  final List arrets;
  final List lignes;

  ArretList(this.arrets, this.lignes) {
    this.arrets.sort((a, b) => a['description']
        .toLowerCase()
        .compareTo(b['description'].toLowerCase()));
  }

  @override
  _ArretListState createState() => _ArretListState();
}

class _ArretListState extends State<ArretList> {
  List arretsStringFiltered;

  @override
  void initState() {
    this.arretsStringFiltered = this.widget.arrets;
    super.initState();
  }

  void filterSearchFilter(String query) {
    this.setState(() {
      this.arretsStringFiltered = this
          .widget
          .arrets
          .where((element) => element["description"].contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0b75b0),
        centerTitle: true,
        title: Text(
          "Liste",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                this.filterSearchFilter(value);
              },
              decoration: InputDecoration(
                labelText: "Recherche",
                hintText: "Recherche",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: this.arretsStringFiltered.length,
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  onTap: () {},
                  title:
                      Text(this.arretsStringFiltered[itemIndex]["description"]),
                  trailing: IconButton(
                    icon: Icon(Icons.star),
                    onPressed: () {},
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
