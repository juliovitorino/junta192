import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaItemUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

class CampanhaItem extends StatefulWidget {

  List _lista;

  CampanhaItem(this._lista);

  @override
  _CampanhaItemState createState() => _CampanhaItemState();
}

class _CampanhaItemState extends State<CampanhaItem> {
  @override
  Widget build(BuildContext context) {

    return widget._lista.length == 0 
    ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhuma campanha encontrada.")
    : new ListView.builder(
      itemCount: widget._lista.length,
      itemBuilder: (BuildContext context, int index){
        return CampanhaItemUI(widget._lista[index]);
      },
    );
  }
}

