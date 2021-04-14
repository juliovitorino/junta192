import 'package:flutter/material.dart';

class CommonOutlineButtonPageRoute extends StatelessWidget {

  Widget pageroute;
  Icon icon;
  String text;

  CommonOutlineButtonPageRoute(this.icon, this.text, this.pageroute);

  @override
  Widget build(BuildContext context) {
    return  OutlineButton(
      onPressed:(){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageroute),
        );
      },
      child: Row(
        children: <Widget>[
          icon,
          Text("$text")
        ],
      ),
    );
  }
}