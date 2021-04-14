import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarioautorizador/UsuarioAutorizadorUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'UsuarioAutorizadorUI.dart';

class UsuarioAutorizadorLV extends StatefulWidget {

  dynamic _pagina;
  String campid;

  UsuarioAutorizadorLV(this.campid, this._pagina);

  @override
  _UsuarioAutorizadorLVState createState() => _UsuarioAutorizadorLVState();
}

class _UsuarioAutorizadorLVState extends State<UsuarioAutorizadorLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){
        return UsuarioAutorizadorUI(widget.campid, widget._pagina['lst'][index]);
      },
    );
  }
}
