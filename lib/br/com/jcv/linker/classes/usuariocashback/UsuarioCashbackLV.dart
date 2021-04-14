import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariocashback/UsuarioCashbackUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'UsuarioCashbackUI.dart';

class UsuarioCashbackLV extends StatefulWidget {

  dynamic _pagina;

  UsuarioCashbackLV(this._pagina);

  @override
  _UsuarioCashbackLVState createState() => _UsuarioCashbackLVState();
}

class _UsuarioCashbackLVState extends State<UsuarioCashbackLV> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget._pagina['lst'].length.toString());
    return widget._pagina['lst'].length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum cartão encontrado.")
        : new ListView.builder(
      itemCount: widget._pagina['lst'].length,
      itemBuilder: (BuildContext context, int index){

        return UsuarioCashbackUI(widget._pagina['lst'][index], color: index == 0 ? Colors.greenAccent : Colors.blueGrey,);
      },
    );
  }
}
