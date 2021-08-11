import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'CampanhaCashbackResgatePixUI.dart';

class CampanhaCashbackResgatePixLV extends StatefulWidget {

  dynamic _pagina;

  CampanhaCashbackResgatePixLV(this._pagina);

  @override
  _CampanhaCashbackResgatePixLVState createState() => _CampanhaCashbackResgatePixLVState();
}

class _CampanhaCashbackResgatePixLVState extends State<CampanhaCashbackResgatePixLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return CampanhaCashbackResgatePixUI(widget._pagina['lst'][index]);
      },
    );
  }
}
