import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

import 'campanhaParticipanteUI.dart';

class CampanhaParticipantesLV extends StatefulWidget {

  dynamic _pagina;

  CampanhaParticipantesLV(this._pagina);

  @override
  _CampanhaParticipantesLVState createState() => _CampanhaParticipantesLVState();
}

class _CampanhaParticipantesLVState extends State<CampanhaParticipantesLV> {
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
        //return Text(widget._pagina['lst'][index]['usuario']['apelido']);
        return CampanhaParticipanteUI(widget._pagina['lst'][index]);
      },
    );
  }
}

