import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashback/CampanhaCashbackUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'CampanhaCashbackUI.dart';

class CampanhaCashbackLV extends StatefulWidget {

  dynamic _pagina;

  CampanhaCashbackLV(this._pagina);

  @override
  _CampanhaCashbackLVState createState() => _CampanhaCashbackLVState();
}

class _CampanhaCashbackLVState extends State<CampanhaCashbackLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return CampanhaCashbackUI(widget._pagina['lst'][index]);
      },
    );
  }
}
