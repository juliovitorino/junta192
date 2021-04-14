import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';

class CartaoSeloDetail extends StatefulWidget {

  dynamic selofull;

  CartaoSeloDetail(this.selofull);

  @override
  _CartaoSeloDetailState createState() => _CartaoSeloDetailState();
}

class _CartaoSeloDetailState extends State<CartaoSeloDetail> {
  @override
  Widget build(BuildContext context) {
    var _autorizador = widget.selofull['usuarioAutorizador'];
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  new CommonImageCircle(_autorizador['urlfoto'], heightcic: 128, widthcic: 128,),
                  SizedBox(height: 20,),
                  Text(_autorizador['apelido'], style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            SizedBox(height: 30,),
            CommonDataItemTitleText("Assintura digital", widget.selofull['qrcode']),
            CommonDataItemTitleText("Data do Carimbo", widget.selofull['dataCadastro']),


          ],
        )
    );
  }
}
