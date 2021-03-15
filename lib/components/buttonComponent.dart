import 'package:flutter/material.dart';

class Buttons {

  Widget positionButton(){
    return ClipOval(
      child: Material(
        color: Colors.green[200], // button color
        child: InkWell(
          splashColor: Colors.blue, // inkwell color
          child: SizedBox(
            width: 70,
            height: 70,
            child: Icon(Icons.remove),
          ),
          onTap: () {}

          ),
        ),
    );
  }
}



