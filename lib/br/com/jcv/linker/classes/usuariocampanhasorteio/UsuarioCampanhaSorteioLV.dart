import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'UsuarioCampanhaSorteioUI.dart';

class UsuarioCampanhaSorteioLV extends StatefulWidget {

  dynamic _pagina;

  UsuarioCampanhaSorteioLV(this._pagina);

  @override
  _UsuarioCampanhaSorteioLVState createState() => _UsuarioCampanhaSorteioLVState();
}

class _UsuarioCampanhaSorteioLVState extends State<UsuarioCampanhaSorteioLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return UsuarioCampanhaSorteioUI(widget._pagina['lst'][index]);
      },
    );
  }
}
