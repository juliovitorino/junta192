import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ticket/cartaoCampanhaUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

class CartoesLV extends StatefulWidget {

  List _listaCartoes;

  CartoesLV(this._listaCartoes);

  @override
  _CartoesLVState createState() => _CartoesLVState();
}

class _CartoesLVState extends State<CartoesLV> {
  @override
  Widget build(BuildContext context) {
debugPrint(widget._listaCartoes.length.toString());
    return widget._listaCartoes.length == 0 
    ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
    : new ListView.builder(
      itemCount: widget._listaCartoes.length,
      itemBuilder: (BuildContext context, int index){
        return CartaoCampanhaUI(widget._listaCartoes[index]);
      },
    );
  }
}

