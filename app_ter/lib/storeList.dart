import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'storeDetailPage.dart';
import 'map.dart';

class StoreList extends StatefulWidget {
  final List data;

  StoreList(this.data) {
    this.data.sort(
        (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
  }

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  List dataStringFiltered;

  @override
  void initState() {
    this.dataStringFiltered = this.widget.data;
    super.initState();
  }

  void filterSearchFilter(String query) {
    this.setState(() {
      this.dataStringFiltered = this
          .widget
          .data
          .where((element) => element["name"].contains(query))
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
              itemCount: this.dataStringFiltered.length,
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  onTap: () {
                    Navigator.of(this.context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return StoreDetailPage(
                              this.dataStringFiltered[itemIndex],
                              Map.currentPeople(
                                  this.dataStringFiltered[itemIndex]
                                      ["sensorsDatas"]));
                        },
                      ),
                    );
                  },
                  title: Text(this.dataStringFiltered[itemIndex]["name"]),
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
