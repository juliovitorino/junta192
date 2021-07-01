import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPerformancePage.dart';

class CampanhaDetail extends StatelessWidget {

  dynamic _cartaofull;

  CampanhaDetail(this._cartaofull);


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          new CommonDataItemTitleText("Campanha",_cartaofull['nome'] ),
          new CommonDataItemTitleText("Recompensa",_cartaofull['recompensa'] ),
          new CommonDataItemTitleText("Texto Eplicativo (Regras)",_cartaofull['textoExplicativo'] ),
          new CommonDataItemTitleText("Data de Início da Campanha",_cartaofull['dataInicio'] ),
          new CommonDataItemTitleText("Data de Término Previsto",_cartaofull['dataTermino'] ),
          new CommonDataItemTitleText("Data e Hora de Criação da Campanha",_cartaofull['dataCadastro'] ),
          new Row(
            children: <Widget>[
              new CommonDataItemTitleText("Máximo Cartões",_cartaofull['maximoCartoes'].toString() ),
              new SizedBox(width: 8.0,),
              new CommonDataItemTitleText("Cartões Distribuídos",_cartaofull['contadorCartoes'].toString() ),
            ]
          ),
          CacheSession().getSession()['isGratuito'] == '1'
          ? new CommomActionButton(titulo: "Ver Performance" , onpressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => new CampanhaPerformancePage(this._cartaofull) ) );
            })
          : Container(height: 0,width: 0),

        ],
      ),
    );
  }
}