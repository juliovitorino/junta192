import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-assistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class AjudaComoReceberRecompensa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CommonAssistente _assistente = new CommonAssistente()
    ..addAssistentePageItem(new AssistenteModel( imgPresente
      , 'Hora da Recompensa!', 'Neste passo a passo você vai aprender como Resgatar e Receber sua recompensa'))
    ..addAssistentePageItem(new AssistenteModel(imgMeusCartoesResgate
      , 'Guia Resgate', 'Localize a Guia Resgate dentro da página Meus Cartões'))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaBtnResgate
      , 'Pedir a Recompensa', 'Com seus carimbos completos, clique no botão RESGATAR RECOMPENSA'))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaCodigoResgate 
      , 'Mostre o Código de Resgate', 'Com seu Código de Resgate construído, mostre-o para o lojista onde você deseja resgatar seu prêmio. Peça para o lojista fazer A VALIDAÇÃO do seu código e liberação da sua recompensa. '))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaAvaliarCampanha
      , 'Avalie a Campanha', 'Depois de receber sua recompensa AVALIE A CAMPANHA dando sua NOTA e SUA OPINIÃO.'))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaAvaliarCampanhaConclusao
      , 'Confirmação da Avaliação', 'Aguarde a mensagem de confirmação da avaliação. Ajude outras pessoas a saber se valeu a pena.'))
    ..addAssistentePageItem(new AssistenteModel(imgPronto
      , 'Pronto!', 'Compartilhe sua experiência com outras pessoas e recomende Junta10 pra elas também se beneficiarem das campanhas.'));

    return Scaffold(
      appBar: new AppBar(title: Text("Como receber a recompensa"),),
      body: _assistente,

    );
  }
}