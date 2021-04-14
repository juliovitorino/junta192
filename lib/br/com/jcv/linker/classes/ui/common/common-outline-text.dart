import 'package:flutter/material.dart';

class CommonOutlineText extends StatelessWidget {

  String text;
  Color color1;
  Color color2;
  double fontsize;
  double strokeWidth;

  CommonOutlineText({Key key, this.strokeWidth=6, @required this.color1, @required this.color2, @required this.text, @required this.fontsize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          style: TextStyle(
            fontSize: fontsize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = color1,
          ),
        ),
        // Solid text as fill.
        Text(
          text ,
          style: TextStyle(
            fontSize: fontsize,
            color: color2,
          ),
        ),
      ],
    );
  }
}