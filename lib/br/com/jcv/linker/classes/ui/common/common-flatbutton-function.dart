import 'package:flutter/material.dart';

class CommonFlatButtonFunction extends StatelessWidget {

  Function function;
  Icon icon;
  String text;
  Color color;

  CommonFlatButtonFunction(this.icon, this.text, this.function, {this.color=Colors.blue});

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      color: color,
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