import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoSeloPage.dart';

class CartaoSelo extends StatefulWidget {
  IconData icon;
  bool ligado;
  String timestamp;
  double tamanho;
  bool timestampshow;
  String autorizador;
  dynamic selofull;

  CartaoSelo(this.icon,
      {this.autorizador,
      this.tamanho=60.0,
      this.ligado=false,
      this.timestampshow=false,
      this.selofull,
      this.timestamp="00/00/0000 00:00:00"});

  @override
  _CartaoSeloState createState() => _CartaoSeloState();
}

class _CartaoSeloState extends State<CartaoSelo> {

  Icon _iconview;
  String _datestamp;
  String _timestamp;
  String _autorizador;

//           1
// 01234567890123456789
// 00/00/0000 00:00:00
  @override
  Widget build(BuildContext context) {
    _iconview = Icon(widget.icon,size: widget.tamanho,color: widget.ligado ? Colors.blue : Colors.grey[300]);
    _datestamp = widget.timestamp.substring(0,10);
    _timestamp = widget.timestamp.substring(11,19);
    _autorizador =  widget.autorizador;
    Widget _widget;

    List<Widget> selo = [_iconview];
    if(widget.timestampshow){
      selo.add(Text(_datestamp, style: TextStyle(fontSize: 9.0)));
      selo.add(Text(_timestamp, style: TextStyle(fontSize: 9.0)));
      selo.add(Text(_autorizador.padRight(10,' ').substring(0,10), style: TextStyle(fontSize: 9.0)));
    }
    //print(widget.selofull.toString());

    _widget = ! widget.timestampshow
      ? Container(child: Column(children: selo))
        : GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new CartaoSeloPage(widget.selofull) ),
              );

            },
            child: Container(child: Column(children: selo)),
          );
    return _widget;
  }
}