import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';

class PlanoUsuarioDetail extends StatelessWidget {

  final Map planousuarioPerfil;

  PlanoUsuarioDetail(this.planousuarioPerfil);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        CommonDataItemTitleText("Nome do Plano", planousuarioPerfil['nome']),
        CommonDataItemTitleText("Valor", planousuarioPerfil['valorMoeda']),
        CommonDataItemTitleText("Data de Aceite", planousuarioPerfil['dataCadastro']),
        CommonDataItemTitleText("Status da conta", planousuarioPerfil['statusdesc'].toUpperCase(), color: Colors.blueAccent,),
      ],
      
    );
  }
}