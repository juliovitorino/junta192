import 'package:flutter/material.dart';

class CommonStatus extends StatelessWidget {

  final IconButton icon;
  final String text;

  CommonStatus({Key key, this.icon, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon == null ?
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {},
            ) : icon,
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14.0),),
          )
          
        ],
      ),
    );
  }
}