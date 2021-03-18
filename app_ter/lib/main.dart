import 'dart:async';
import 'package:app_ter/connecter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(
        title: "Commmerces",
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
  Connecter connecter = Connecter(Credentials.connectionString);

  List data;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/stores.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  void openDrawer() {
    this._scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future<void>.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Scaffold(
          key: this._scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: CustomDrawer(),
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 80,
            backgroundColor: Color(0xFF0b75b0),
            elevation: 0,
            shadowColor: Colors.blue,
            title: Text(
              widget.title,
              style: GoogleFonts.sacramento(fontSize: 50),
            ),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                this.openDrawer();
              },
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.map,
                  ),
                  onPressed: () {}),
            ],
          ),
          body: Column(
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
              Container(
                height: 379,
                width: 400,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: snapshot.connectionState == ConnectionState.done
                      ? MapSample(this.data)
                      : SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                              strokeWidth: 10,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RoundedBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..lineTo(0, size.height - 80)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 80)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CommercesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
