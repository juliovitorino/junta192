import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoSelo.dart';

class CartaoCarimbos15 extends StatefulWidget {
  dynamic _cartaofull;
  bool timestampshow;

  CartaoCarimbos15(this._cartaofull, {this.timestampshow=false});

  @override
  _CartaoCarimbos15State createState() => _CartaoCarimbos15State();
}

class _CartaoCarimbos15State extends State<CartaoCarimbos15> {

  final double SIZE_CARIMBO = 60.0;

  @override
  Widget build(BuildContext context) {

    List<Widget> lstSelos = [];

    for (var i = 0; i < widget._cartaofull['cartao']['contador']; i++) {
      if(widget.timestampshow){
        lstSelos.add(new CartaoSelo(Icons.star, 
            tamanho: SIZE_CARIMBO, 
            ligado: true, 
            timestampshow: true,
            timestamp: widget._cartaofull['cartao']['lstcarimbos'][i]['dataCadastro'],
            autorizador: widget._cartaofull['cartao']['lstcarimbos'][i]['usuarioAutorizador']['apelido'],
            selofull: widget._cartaofull['cartao']['lstcarimbos'][i],
          )
        );
      } else {
        lstSelos.add(new CartaoSelo(Icons.star, tamanho: SIZE_CARIMBO, ligado: true,));

      }
    }

    for (var i = 0; i < widget._cartaofull['campanha']['maximoSelos'] - widget._cartaofull['cartao']['contador']; i++) {
      lstSelos.add(new CartaoSelo(Icons.star, tamanho: SIZE_CARIMBO));
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            lstSelos[0],
            lstSelos[1],
            lstSelos[2],
            lstSelos[3],
            lstSelos[4],
          ],
        ),
        Row(
          children: <Widget>[
            lstSelos[5],
            lstSelos[6],
            lstSelos[7],
            lstSelos[8],
            lstSelos[9],
          ],
        ),
        Row(
          children: <Widget>[
            lstSelos[10],
            lstSelos[11],
            lstSelos[12],
            lstSelos[13],
            lstSelos[14],
          ],
        ),
        
        
      ],
      
    );
  }
}