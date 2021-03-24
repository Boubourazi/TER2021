import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: Text(
                "Paramètres",
                style:
                    GoogleFonts.sacramento(fontSize: 40, color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(color: Color(0xFF0b75b0)),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.account_circle),
            title: Text("Utilisateur"),
          )
        ],
      ),
    );
  }
}
