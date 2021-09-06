import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';

class UsuarioDetail extends StatelessWidget {

  final Map usuarioPerfil;

  UsuarioDetail(this.usuarioPerfil);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        CommonImageCircle(usuarioPerfil['urlfoto'], widthcic: 128, heightcic: 128),
        CommonDataItemTitleText("Nome", usuarioPerfil['apelido']),
        CommonDataItemTitleText("Email", usuarioPerfil['email']),
        CommonDataItemTitleText("Data de cadastro", usuarioPerfil['dataCadastro']),
        CommonDataItemTitleText("Status da conta", usuarioPerfil['statusdesc'].toUpperCase(), color: Colors.blueAccent,),
      ],
      
    );
  }
}