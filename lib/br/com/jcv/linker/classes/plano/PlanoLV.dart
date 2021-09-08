import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'PlanoUI.dart';

class PlanoLV extends StatefulWidget {

  dynamic _pagina;

  PlanoLV(this._pagina);

  @override
  _PlanoLVState createState() => _PlanoLVState();
}

class _PlanoLVState extends State<PlanoLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return PlanoUI(widget._pagina['lst'][index]);
      },
    );
  }
}




























































































































































































































































































