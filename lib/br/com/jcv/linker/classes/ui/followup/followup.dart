import 'package:flutter/material.dart';

class Followup extends StatefulWidget {

  String title;
  String subtitle;
  int status;
  int _cartao_status;

  Followup(this.title, this.subtitle, this.status, this._cartao_status);


  @override
  _FollowupState createState() => _FollowupState();

}

class _FollowupState extends State<Followup> {
  @override
  Widget build(BuildContext context) {

    Widget _widget;
    Color _backcolor;

    if(widget._cartao_status == -1) {
      _widget = Text(widget.title, style: TextStyle(color: Colors.white));
      _backcolor = Colors.grey[300];
    } else if (widget._cartao_status  > widget.status) {
      _widget = Icon(Icons.check);
      _backcolor = Colors.green;
    } else if (widget._cartao_status  == widget.status) {
      _backcolor = Colors.blue;
      _widget = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(widget.title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else if (widget._cartao_status  < widget.status) {
      _backcolor = Colors.grey[300];
      _widget = Text(widget.title, style: TextStyle(color: Colors.black45));
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
            radius: 20,
            backgroundColor: _backcolor,
            child: _widget
        ),
        Text(widget.subtitle)
      ],
    );


  }
}
