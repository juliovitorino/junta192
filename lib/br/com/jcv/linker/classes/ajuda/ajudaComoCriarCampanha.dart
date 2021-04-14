import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-assistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class AjudaComoCriarCampanha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CommonAssistente _assistente = new CommonAssistente()
    ..addAssistentePageItem(new AssistenteModel( imgAjudaCCCPasso[0]
      , 'Bem Vindo', 'Este passo a passo vai te ajudar a construir e colocar sua campanha de fidelidade pra funcionar.'))
    ..addAssistentePageItem(new AssistenteModel(imgSobreJ10
      , 'O que é uma Campanha?', 'Todo CARTÃO FIDELIDADE a ser usado por um cliente é baseado em UMA CAMPANHA. É nela que você vai definir um prêmio a ser dado ao cliente que completar um cartão.'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[1]
      , 'Passo 1', 'Clique no menu Minhas Campanhas'))
    ..addAssistentePageItem(new AssistenteModel( imgAjudaCCCPasso[2]
      , 'Passo 2', 'Clique no botão Adicionar Nova Campanha.'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[3]
      , 'Passo 3', 'Digite o nome da sua Campanha, por ex: PROMOÇÃO DE ANIVERSÁRIO'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[4]
      , 'Passo 4', 'Digite a recompensa da sua Campanha, por ex: Ganha 1 Corte de Cabelo ou Ganha 1 X-TUDO + 1 Refrigerante de 600ML'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[5]
      , 'Passo 5', 'Clique no botão criar Campanha e Aguarde...'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[6]
      , 'Campanha Criada ... Quase pronto', 'Sua campanha foi criada mas só FALTA CRIAR OS CARIMBOS... Vamos lá!'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[7]
      , 'Último Passo', 'Mande agora o Junta10 produzir os carimbos da sua Campanha pressionando o botão CRIAR CARIMBOS e aguarde.'))
    ..addAssistentePageItem(new AssistenteModel(imgAjudaCCCPasso[8]
      , 'Pronto!', 'Sua campanha está pronta e agora é só liberar os carimbos para quem consumir seus produtos'));

    return Scaffold(
      appBar: new AppBar(title: Text("Como Criar Campanha"),),
      body: _assistente,

    );
  }
}