import 'package:flutter/material.dart';

class CommonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
    child: Padding(
      padding: EdgeInsets.only(top:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text("  Verificando Internet... ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
        ],
      ),
    )
  );
  }
}