import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'UsuarioCampanhaSorteioTicketUI.dart';

class UsuarioCampanhaSorteioTicketLV extends StatefulWidget {

  dynamic _pagina;

  UsuarioCampanhaSorteioTicketLV(this._pagina);

  @override
  _UsuarioCampanhaSorteioTicketLVState createState() => _UsuarioCampanhaSorteioTicketLVState();
}

class _UsuarioCampanhaSorteioTicketLVState extends State<UsuarioCampanhaSorteioTicketLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return UsuarioCampanhaSorteioTicketUI(widget._pagina['lst'][index]);
      },
    );
  }
}
