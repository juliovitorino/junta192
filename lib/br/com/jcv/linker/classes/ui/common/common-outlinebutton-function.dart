import 'package:flutter/material.dart';

class CommonOutlineButtonFunction extends StatelessWidget {

  Function function;
  Icon icon;
  String text;

  CommonOutlineButtonFunction(this.icon, this.text, this.function);

  @override
  Widget build(BuildContext context) {
    return  OutlineButton(
      onPressed: function ,
      child: Row(
        children: <Widget>[
          icon,
          Text("$text")
        ],
      ),
    );
  }
}