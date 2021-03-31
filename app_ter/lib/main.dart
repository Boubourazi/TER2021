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
        title: "Commerces",
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

  List data = [];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/stores.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    //this.loadJsonData();
  }

  void loadMarkers() async {
    this
        ._connecter
        .initialize()
        .then((value) =>
            this._connecter.db.collection("commerces").find().toList())
        .then((value2) => this.setState(() {
              this.data = value2;
            }));
  }

  void openDrawer() {
    this._scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this._connecter.initialize().then((value) =>
            this._connecter.db.collection("commerces").find().toList()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
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
                if (snapshot.connectionState == ConnectionState.done)
                  IconButton(
                    icon: Icon(
                      Icons.list,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return StoreList(snapshot.data);
                          },
                        ),
                      );
                    },
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.blue[200],
                        strokeWidth: 1,
                      ),
                    ),
                  ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                snapshot.connectionState == ConnectionState.done
                    ? Map(snapshot.data)
                    : snapshot.hasError
                        ? Text("Error mongo db")
                        : Map([]),
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
              onPressed: () {},
            ),
          );
        });
  }
}
