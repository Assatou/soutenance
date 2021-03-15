import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:caisse/components/utils/rounded_button.dart';
import 'package:caisse/components/utils/text_field_container.dart';
import 'package:caisse/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('');
      }
    });
  }

  //values object
  String price_value = "0";
  String quantity_value = "0";
  String name_value = "";
  bool _isLoading = false;
  String qrCodeResult = "";
  String myvalue = "";

  Future<List> senddata() async {
    var response = await http.post("bad-event.com/caisse/produit.php", body: {
      "idqrcode": qrCodeResult,
      "nom": price_value,
      "quantite": quantity_value,
      "prix": name_value,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
//----------------SCANNER--------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  String codeScanner =
                      await BarcodeScanner.scan(); //barcode scanner
                  setState(() {
                    qrCodeResult = codeScanner;
                  });
                  SizedBox(
                    height: 40,
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: kPrimaryLightColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.scanner),
                ),
              ),
              GestureDetector(
                onTap: getImage,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: kPrimaryLightColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.image),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),
          _image == null ? Text('') : Image.file(_image),

          // // FlatButton(
          // //   onPressed: getImage,
          // //   child: Icon(Icons.add_a_photo),
          // // ),
          // FlatButton(
          //   child: Icon(Icons.add_a_photo),
          //   padding: EdgeInsets.all(15.0),
          //   onPressed: () async {
          //     setState(() {
          //     });
          //     SizedBox(
          //       height: 20,
          //     );
          //   },
          // ),
          SizedBox(
            height: 20,
          ),

//-----------------L'ID DU PRODUIT RECUPERER A PARTIR DU CODE QR ------------------------------
          Text(
            qrCodeResult,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 20,
          ),

//------------------QUANTITY-----------------------------------------
          TextFieldContainer(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  name_value = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  name_value = value;
                });
              },
              // cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.preview_outlined,
                  color: kPrimaryColor,
                ),
                hintText: "Nom produit",
                labelText: "Nom produit",
                border: InputBorder.none,
              ),
            ),
          ),
          // TextFormField(
          //   controller: nom,
          //   decoration: InputDecorationgit(
          //       labelText: 'Nom produit', border: OutlineInputBorder()),
          // ),
          SizedBox(height: 10.0),

//------------------QUANTITY-----------------------------------------
          TextFieldContainer(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  quantity_value = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  quantity_value = value;
                });
              },
              // cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.shopping_basket,
                  color: kPrimaryColor,
                ),
                hintText: "Quantité",
                labelText: "Quantité",
                border: InputBorder.none,
              ),
            ),
          ),

          // TextFormField(
          //   controller: quantite,
          //   decoration: InputDecoration(
          //       labelText: 'Quantité ', border: OutlineInputBorder()),
          // ),
          SizedBox(height: 10.0),

//------------------PRICE-----------------------------------------
          TextFieldContainer(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  price_value = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  price_value = value;
                });
              },
              // cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.money_sharp,
                  color: kPrimaryColor,
                ),
                hintText: "Prix",
                labelText: "Prix",
                border: InputBorder.none,
              ),
            ),
          ),

          // TextFormField(
          //   controller: prix,
          //   decoration: InputDecoration(
          //       labelText: 'Prix', border: OutlineInputBorder()),
          // ),
          SizedBox(height: 10.0),

//----------------------LE BOUTON POUR ENVOYER LES DONNEES -------------------------------

          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : new RoundedButton(
                  text: "Envoyer",
                  press: () {
                    print('Envoyer');

//----------------------APPELER L'API--------------------------------
                    senddata();
                  },
                ),
          // RaisedButton(
          //   onPressed: () {},
          //   child: Text(
          //     'Envoyer',
          //     style: TextStyle(
          //         color: Colors.lightGreen, fontWeight: FontWeight.bold),
          //   ),
          //   shape: RoundedRectangleBorder(
          //       side: BorderSide(color: Colors.yellow, width: 3.0),
          //       borderRadius: BorderRadius.circular(20.0)),
          // ),
        ],
      ),
    ));
  }
}
