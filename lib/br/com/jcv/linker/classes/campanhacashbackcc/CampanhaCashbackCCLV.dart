import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackcc/CampanhaCashbackCCUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'CampanhaCashbackCCUI.dart';

class CampanhaCashbackCCLV extends StatefulWidget {

  dynamic _pagina;

  CampanhaCashbackCCLV(this._pagina);

  @override
  _CampanhaCashbackCCLVState createState() => _CampanhaCashbackCCLVState();
}

class _CampanhaCashbackCCLVState extends State<CampanhaCashbackCCLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['sldUsuarioDono'].length.toString());
    return widget._pagina['sldUsuarioDono'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['sldUsuarioDono'].length,
      itemBuilder: (BuildContext context, int index){

        return CampanhaCashbackCCUI(widget._pagina['sldUsuarioDono'][index]);
      },
    );
  }
}
