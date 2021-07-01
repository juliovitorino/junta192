import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'CampanhaSorteioUI.dart';

class CampanhaSorteioLV extends StatefulWidget {

  dynamic _pagina;

  CampanhaSorteioLV(this._pagina);

  @override
  _CampanhaSorteioLVState createState() => _CampanhaSorteioLVState();
}

class _CampanhaSorteioLVState extends State<CampanhaSorteioLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return CampanhaSorteioUI(widget._pagina['lst'][index]);
      },
    );
  }
}
