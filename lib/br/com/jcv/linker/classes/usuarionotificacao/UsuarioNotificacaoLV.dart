import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarionotificacao/UsuarioNotificacaoUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'UsuarioNotificacaoUI.dart';

class UsuarioNotificacaoLV extends StatefulWidget {

  dynamic _pagina;

  UsuarioNotificacaoLV(this._pagina);

  @override
  _UsuarioNotificacaoLVState createState() => _UsuarioNotificacaoLVState();
}

class _UsuarioNotificacaoLVState extends State<UsuarioNotificacaoLV> {
  @override
  Widget build(BuildContext context) {

    bool erro = false;
    if(widget._pagina['msgcode'] == 'MSG-0083' ||
       widget._pagina['msgcode'] == 'MSG-0095'     
       ) {
      erro = true;
    }

    return erro
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: widget._pagina['msgcodeString'])
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return UsuarioNotificacaoUI(widget._pagina['lst'][index]);
      },
    );
  }
}
