import 'package:flutter/material.dart';

class CommonContentHeading extends StatelessWidget {

  final String heading;
  final TextStyle style;

  CommonContentHeading({@required this.heading, @required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(heading, style: style),
    );
  }
}