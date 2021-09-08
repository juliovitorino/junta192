import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';

class PlanoDetail extends StatelessWidget {

  final Map planoDetail;

  PlanoDetail(this.planoDetail);

  @override
  Widget build(BuildContext context) {

   List<Widget> _lstCamposPlanoDetail = [];

   if(this.planoDetail != null)
   {
      if(planoDetail['id'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("ID do Plano", planoDetail['id']));
      if(planoDetail['nome'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Nome do Plano", planoDetail['nome']));
      if(planoDetail['permissao'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Estruturas de Permissão do Plano", planoDetail['permissao']));
      if(planoDetail['valor'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Valor do Plano", planoDetail['valor']));
      if(planoDetail['tipo'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Tipo do Plano", planoDetail['tipo']));
      if(planoDetail['status'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Status", planoDetail['status']));
      if(planoDetail['dataCadastro'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Data de Cadastro", planoDetail['dataCadastro']));
      if(planoDetail['dataAtualizacao'] != null) _lstCamposPlanoDetail.add(CommonDataItemTitleText("Data de Atualização", planoDetail['dataAtualizacao']));
   }

    return Column(
      children: _lstCamposPlanoDetail,
      
    );
  }
}
