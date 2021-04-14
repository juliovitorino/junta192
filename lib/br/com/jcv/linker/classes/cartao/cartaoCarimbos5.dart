import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoSelo.dart';

class CartaoCarimbos5 extends StatefulWidget {
  dynamic _cartaofull;
  bool timestampshow;

  CartaoCarimbos5(this._cartaofull, {this.timestampshow=false});

  @override
  _CartaoCarimbos5State createState() => _CartaoCarimbos5State();
}

class _CartaoCarimbos5State extends State<CartaoCarimbos5> {

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
      ],
      
    );
  }
}