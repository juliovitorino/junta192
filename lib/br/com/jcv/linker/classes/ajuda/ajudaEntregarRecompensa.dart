import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-assistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class AjudaComoEntregarRecompensa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CommonAssistente _assistente = new CommonAssistente()
    ..addAssistentePageItem(new AssistenteModel( imgPresente
      , 'Entregar Recompensa!', 'Neste passo a passo você vai aprender como Entregar a recompensa ao cliente que completou o CARTÃO FIDELIDADE.'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[1]
      , 'Vá em suas campanhas', 'Clique no menu Minhas Campanhas'))      
    ..addAssistentePageItem(new AssistenteModel(imgAjudaEntregarRecompensa
      , 'Inicie a Entrega', 'CLIQUE na opção ENTREGAR RECOMPENSA'))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaCodigoResgate 
      , 'Peça o Código de Resgate', 'Peça o Código de Resgate ao cliente para fazer A VALIDAÇÃO e liberação da recompensa. '))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaValidarCartao 
      , 'Valide o Código', 'Aponte seu celular para o Código de Resgate do cliente e capture-o para o Junta10 validar o código e seguir para próxima etapa. '))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaCodigoValidadoSucesso
      , 'Hora da Entrega!', 'Essa Mensagem indica que o CÓDIGO FOI VALIDADO COM SUCESSO. É hora de entregar o brinde e confirmar a entrega.'))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaEntregarRecompesa
      , 'Hora da Conquista!', 'Entregue o BRINDE AO CLIENTE e confirme o registro de entrega. '))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaAvaliarCampanha
      , 'OOOpss! Não Esqueça de ...', 'Peça para o cliente EMITIR UMA AVALIAÇÃO IMEDIATAMENTE para que outras pessoas participantes fiquem ESTIMULADAS A CONSUMIR MAIS.'));

    return Scaffold(
      appBar: new AppBar(title: Text("Como entregar a recompensa"),),
      body: _assistente,

    );
  }
}