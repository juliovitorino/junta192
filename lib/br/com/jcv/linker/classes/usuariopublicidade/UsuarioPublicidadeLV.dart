import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/UsuarioPublicidadeUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'UsuarioPublicidadeUI.dart';

class UsuarioPublicidadeLV extends StatefulWidget {

  dynamic _pagina;

  UsuarioPublicidadeLV(this._pagina);

  @override
  _UsuarioPublicidadeLVState createState() => _UsuarioPublicidadeLVState();
}

class _UsuarioPublicidadeLVState extends State<UsuarioPublicidadeLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return UsuarioPublicidadeUI(widget._pagina['lst'][index]);
      },
    );
  }
}
