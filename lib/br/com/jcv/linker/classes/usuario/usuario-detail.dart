import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/text_styles.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/contente_heading.dart';

class UsuarioDetail extends StatelessWidget {

  final Map usuarioPerfil;
  final Map usuarioComplemento;

  UsuarioDetail(this.usuarioPerfil, this.usuarioComplemento);

  @override
  Widget build(BuildContext context) {

   List<Widget> _lstCamposUsuarioDetail = [];
   _lstCamposUsuarioDetail.add(CommonImageCircle(usuarioPerfil['urlfoto'], widthcic: 128, heightcic: 128));
   _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Nome", usuarioPerfil['apelido']));
   _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Email", usuarioPerfil['email']));
   _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Data de cadastro", usuarioPerfil['dataCadastro']));
   _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Status da conta", usuarioPerfil['statusdesc'].toUpperCase(), color: Colors.blueAccent));

   // Precisa colocar as informações complementares?
   if(this.usuarioComplemento != null)
   {
      _lstCamposUsuarioDetail.add(CommonContentHeading(heading: "Informações Complementares", style: uiTextStylePadrao));
      if(usuarioComplemento['ddd'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("DDD", usuarioComplemento['ddd']));
      if(usuarioComplemento['telefone'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Telefone", usuarioComplemento['telefone']));
      if(usuarioComplemento['nomeReceitaFederal'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Registro R.F.", usuarioComplemento['nomeReceitaFederal']));
      if(usuarioComplemento['nomeResponsavel'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Responsavel R.F.", usuarioComplemento['nomeResponsavel']));
      if(usuarioComplemento['urlsite'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Site", usuarioComplemento['urlsite'], color: Colors.blueAccent));
      if(usuarioComplemento['urlFacebook'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Facebook", usuarioComplemento['urlFacebook'], color: Colors.blueAccent));
      if(usuarioComplemento['urlInstagram'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Instagram", usuarioComplemento['urlInstagram'], color: Colors.blueAccent));
      if(usuarioComplemento['urlPinterest'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Pinterest", usuarioComplemento['urlPinterest']));
      if(usuarioComplemento['urlSkype'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Skype", usuarioComplemento['urlSkype']));
      if(usuarioComplemento['urlTwitter'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Twitter", usuarioComplemento['urlTwitter']));
      if(usuarioComplemento['urlFacetime'] != null) _lstCamposUsuarioDetail.add(CommonDataItemTitleText("Facetime", usuarioComplemento['urlFacetime']));

   }

    return Column(
      children: _lstCamposUsuarioDetail,
      
    );
  }
}