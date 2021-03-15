import 'package:caisse/constants.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    bool showPassword = false;
    return TextFieldContainer(
      child: TextField(
        obscureText: showPassword == true ? false : true,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "xxxxxxxxxxxxxxxxx",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: kPrimaryColor,
            onPressed: () {
              print('show password');
              setState(() {
                showPassword = true;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

/*
class RoundedPasswordField extends StatelessWidget {

  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showPassword = false;

    return TextFieldContainer(
      child: TextField(
        obscureText: showPassword == true ?   false :  true,
        onChanged:  onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: kPrimaryColor,
            onPressed: () {
              print('show password');
              showPassword = true;
              set
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
*/
