import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-assistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class AjudaComoLiberarCarimbos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CommonAssistente _assistente = new CommonAssistente()
    ..addAssistentePageItem(new AssistenteModel( imgBemVindoCriarCarimbo
      , 'Bem Vindo', 'Este passo a passo vai te ensinar liberar os carimbos pra sua Campanha de Fidelidade de Clientes'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[1]
      , 'Passo 1', 'Clique no menu Minhas Campanhas'))
    ..addAssistentePageItem(new AssistenteModel(imgLiberarCarimbo
      , 'Passo 2', 'Clique no botão LIBERAR CARIMBOS'))
    ..addAssistentePageItem(new AssistenteModel(imgLiberarNovoCarimbo
      , 'Último Passo', 'Clique no botão LIBERAR NOVO CARIMBO ou você também pode tocar na imagem do QRCode'))
    ..addAssistentePageItem(new AssistenteModel(imgLiberarCarimboFinalizado
      , 'Pronto!', 'Seu carimbo FOI CRIADO COM SUCESSO e já pode ser apresentado ao seu cliente para carimbar o Cartão Fidelidade Digital'))
    ..addAssistentePageItem(new AssistenteModel(imgVendedorFemQrCode
      , 'Pronto!', 'Agora é só apresentar ao cliente para ele capturar o QRCode'));

    return Scaffold(
      appBar: new AppBar(title: Text("Como Liberar Carimbo"),),
      body: _assistente,

    );
  }
}