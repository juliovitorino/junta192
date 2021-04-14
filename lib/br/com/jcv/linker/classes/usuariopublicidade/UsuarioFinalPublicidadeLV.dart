import 'package:flutter/material.dart';
import '../ui/common/common-msgcode.dart';
import '../usuariopublicidade/UsuarioFinalPublicidadeUI.dart';

class UsuarioFinalPublicidadeLV extends StatefulWidget {

  dynamic _pagina;

  UsuarioFinalPublicidadeLV(this._pagina);

  @override
  _UsuarioFinalPublicidadeLVState createState() => _UsuarioFinalPublicidadeLVState();
}

class _UsuarioFinalPublicidadeLVState extends State<UsuarioFinalPublicidadeLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return UsuarioFinalPublicidadeUI(widget._pagina['lst'][index]);
      },
    );
  }
}
