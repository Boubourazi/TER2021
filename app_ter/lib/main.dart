import 'dart:async';
import 'package:app_ter/arretList.dart';
import 'package:app_ter/arretMap.dart';
import 'package:app_ter/connecter.dart';
import 'package:app_ter/storeList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'storeList.dart';
import 'roundedBottom.dart';
import 'storeMap.dart';
import 'credentials.dart';
import 'custom_drawer.dart';
import 'airMap.dart';
import 'airQualityPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion bus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: GoogleFonts.sacramento(fontSize: 50, color: Colors.white),
          headline2: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
          headline3: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      home: MyHomePage(
        title: "Carte",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Connecter _connecter = Connecter(Credentials.connectionString);

  int _selectedIndex = 0;
  bool showCommerces = true;

  bool showParkings = true;

  List data = [];

  List arrets = [];

  List lignes = [];

  List<Polygon> polygons = [];

  List parkings = [];

  List<Widget> _menus = <Widget>[
    Center(child: StoreMap([])),
    Center(child: StoreMap([])),
    Center(child: StoreMap([])),
    Center(child: AirMap([])),
  ];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/aquitaineGeoJSON.json');
    var data = json.decode(jsonText);
    setState(() {
      List<Widget> je = this._menus;

      List<Polygon> polygons = List.from(data['features'].map((e) {
        List<LatLng> points = List.from(e['geometry']['coordinates'][0]
            .map((e) => new LatLng(e[1], e[0]))
            .toList());
        return new Polygon(
          polygonId: PolygonId(e['properties']['nom']),
          points: points,
          strokeColor: Colors.grey,
          strokeWidth: 1,
          fillColor: Colors.green[300],
        );
      }).toList());
      je[3] = AirMap(polygons);
      this._menus = je;
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
    this.loadMarkers();
  }

  void loadMarkers() async {
    this
        ._connecter
        .initialize()
        .then((_) => this._connecter.db.collection("commerces").find().toList())
        .then((store) => this.setState(() {
              this.data = store;
              List<Widget> je = this._menus;
              je[0] = StoreMap(this.data);
              this._menus = je;
            }))
        .then((_) => this._connecter.db.collection("parkings").find().toList())
        .then((parkings) => this.setState(() {
              this.parkings = parkings;
              List<Widget> je = this._menus;
              print(this.parkings);
              je[2] = StoreMap(this.parkings);
              this._menus = je;
            }))
        .then((_) => this._connecter.db.collection("arrets").find().toList())
        .then((arrets) => this.setState(() {
              this.arrets = arrets;
            }))
        .then((_) => this._connecter.db.collection("lignes").find().toList())
        .then((lignes) => this.setState(() {
              this.lignes = lignes;
            }))
        .then((_) => this.setState(() {
              this.parkings = parkings;
              List<Widget> je = this._menus;
              print(this.parkings);
              je[1] = ArretMap(this.arrets, this.lignes);
              this._menus = je;
            }));
  }

  void reloadMarkers() async {
    this._connecter.db.collection("commerces").find().toList().then((value2) {
      this.setState(() {
        this.data = value2;
        List<Widget> je = this._menus;
        je[0] = StoreMap(this.data);
        this._menus = je;
      });
      print("State has been changed !");
    });
  }

  void openDrawer() {
    this._scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Colors.white, //Color(0xFF0b75b0),
      key: this._scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.indigo[800],
        currentIndex: this._selectedIndex,
        onTap: (int index) {
          this.setState(() {
            print(this._selectedIndex);
            this._selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Commerces",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_bus,
            ),
            label: "Bus",
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_parking,
            ),
            label: "Parking",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: "Air",
            backgroundColor: Colors.orange,
          )
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: Color(0xFF0b75b0),
        elevation: 0,
        shadowColor: Colors.blue,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            this.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    switch (this._selectedIndex) {
                      case 0:
                        return StoreList(this.data);
                        break;
                      case 1:
                        return ArretList(this.arrets, this.lignes);
                        break;
                      case 2:
                        return StoreList(this.parkings);
                        break;
                      case 3:
                        return AirQualityPage();
                        break;
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          this._menus.elementAt(this._selectedIndex),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.autorenew),
        onPressed: () {
          this.loadMarkers();
        },
      ),
    );
  }
}
