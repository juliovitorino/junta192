import 'package:flutter/material.dart';

class CommonFlatButtonPageRoute extends StatelessWidget {

  Widget pageroute;
  Icon icon;
  String text;

  CommonFlatButtonPageRoute(this.icon, this.text, this.pageroute);

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      color: Colors.blue,
      onPressed:(){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageroute),
        );
      },
      child: Row(
        children: <Widget>[
          icon,
          Text("$text", style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}