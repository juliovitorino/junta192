import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonDataItemTitleText extends StatelessWidget {

  String title;
  String text;
  double sizetext;

  CommonDataItemTitleText(this.title, this.text, {this.sizetext=16.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Text(this.title, 
          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16.0

        ),),
        Text(this.text, 
          style: TextStyle( color: Colors.black54, fontSize: sizetext),),
        Divider()

      ],
    );
  }
}