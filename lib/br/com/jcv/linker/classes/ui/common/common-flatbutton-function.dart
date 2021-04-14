import 'package:flutter/material.dart';

class CommonFlatButtonFunction extends StatelessWidget {

  Function function;
  Icon icon;
  String text;

  CommonFlatButtonFunction(this.icon, this.text, this.function);

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      color: Colors.blue,
      onPressed: function ,
      child: Row(
        children: <Widget>[
          icon,
          Text(" $text", style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}