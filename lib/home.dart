import 'package:caisse/produit.dart';
import 'package:caisse/scan.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class Firstroute extends StatelessWidget {
  final String title;

  Firstroute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Scan();
                }),
              );
            },
            child: Text(
              'Scanner',
              style: new TextStyle(
                  color: Colors.lightGreen, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.yellow, width: 3.0),
                borderRadius: BorderRadius.circular(20.0)),
          ),
          RaisedButton(
            child: Text(
              'voir mon stock',
              style: new TextStyle(
                  color: Colors.lightGreen, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.yellow, width: 3.0),
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return prod();
                }),
              );
            },
          ),
        ],
      )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.

          children: <Widget>[
            DrawerHeader(
              child: CircularProfileAvatar(
                null,
                child: Image.asset('caisse.png'),
                borderWidth: 1,
                elevation: 1,
                radius: 150,
              ),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Site Web'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Scan();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Scan();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
