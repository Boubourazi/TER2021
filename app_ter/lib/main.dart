import 'dart:async';
import 'package:app_ter/connecter.dart';
import 'package:app_ter/storeList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'storeList.dart';
import 'roundedBottom.dart';
import 'map.dart';
import 'credentials.dart';
import 'custom_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion bus ',
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

  bool showCommerces = true;

  bool showParkings = true;

  List data = [];
  List parkings = [];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/stores.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    //this.loadJsonData();
    this.loadMarkers();
  }

  void loadMarkers() async {
    this
        ._connecter
        .initialize()
        .then((_) => this._connecter.db.collection("commerces").find().toList())
        .then((store) => this.setState(() {
              this.data = store;
            }))
        .then((_) => this._connecter.db.collection("parkings").find().toList())
        .then((parkings) => this.setState(() {
              this.parkings = parkings;
            }));
  }

  void reloadMarkers() async {
    this._connecter.db.collection("commerces").find().toList().then((value2) {
      this.setState(() {
        this.data = value2;
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
                    return StoreList(this.data);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Map(
            this.showCommerces && this.showParkings
                ? [...this.data, ...this.parkings]
                : this.showCommerces
                    ? this.data
                    : this.showParkings
                        ? this.parkings
                        : [],
          ),
          Positioned(
            top: 450,
            left: 15,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.7),
              ),
              duration: Duration(milliseconds: 400),
              height: 25,
              width: 25,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(15),
                color: this.showCommerces ? Colors.blue : Colors.white,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      this.showCommerces = !this.showCommerces;
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 490,
            left: 15,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.7),
              ),
              duration: Duration(milliseconds: 400),
              height: 25,
              width: 25,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(15),
                color: this.showParkings ? Colors.blue : Colors.white,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      this.showParkings = !this.showParkings;
                    });
                  },
                ),
              ),
            ),
          ),
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
          this.reloadMarkers();
        },
      ),
    );
  }
}