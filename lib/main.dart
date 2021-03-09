import 'dart:convert';

import 'package:caisse/home.dart';
import 'package:caisse/scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Scan(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signin = true;

  TextEditingController namectrl, emailctrl, passctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Image.asset('caisse.png'),
            boxUi(),
          ],
        ));
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else
      setState(() {
        signin = true;
      });
  }

  void registerUser() async {
    setState(() {
      processing = true;
    });
    var url = "http://bad-event.com/caisse/inscription.php";
    var data = {
      "name": namectrl.text,
      "email": emailctrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "account created",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    setState(() {
      processing = false;
      signin = true;
    });
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });

    var res =
        await http.post('http://bad-event.com/caisse/connexion.php', body: {
      "email": emailctrl.text,
      "pass": passctrl.text,
    });

    var dataUser = jsonDecode(res.body);

    if (res.statusCode == 200) {
      print(dataUser);
      Fluttertoast.showToast(
          msg: "Connexion réussie", toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Firstroute()));
    }
    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'CONNEXION',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.yellow : Colors.lightGreen,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'INSCRIPTION',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.yellow : Colors.lightGreen,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            signin == true ? signInUi() : signUpUi(),
          ],
        ),
      ),
    );
  }

  Widget signInUi() {
    return Column(
      children: <Widget>[
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
              ),
              hintText: 'email'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: 'pass'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
            onPressed: () => userSignIn(),
            child: processing == false
                ? Text(
                    'Connexion',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0, color: Colors.lightGreen),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  )),
      ],
    );
  }

  Widget signUpUi() {
    return Column(
      children: <Widget>[
        TextField(
          controller: namectrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'name'),
        ),
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
              ),
              hintText: 'email'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: 'pass'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
            onPressed: () => registerUser(),
            child: processing == false
                ? Text(
                    'Inscription',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0, color: Colors.lightGreen),
                  )
                : CircularProgressIndicator(backgroundColor: Colors.yellow)),
      ],
    );
  }

// now we will setup php and database
//thank you
}
