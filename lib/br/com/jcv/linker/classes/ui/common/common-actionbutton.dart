import 'package:flutter/material.dart';

class CommomActionButton extends StatelessWidget {

  String titulo;
  Function onpressed;
  Color color;

  CommomActionButton({Key key, @required this.titulo, @required this.onpressed, this.color=Colors.green}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      height: 50.0,
      child: RaisedButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              onPressed: onpressed,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(titulo, 
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
              ),
              color: color
            )
    );
  }
}