import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaCancelar.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaCashback.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaDetail.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaExcluir.dart';

class CampanhaDetailPage extends StatelessWidget {

  dynamic _cartaofull;
  String acao;

  CampanhaDetailPage(this._cartaofull, {this.acao = "V"});

  @override
  Widget build(BuildContext context) {

    Widget _bodyview;
    String _titleview;

    if(acao == "V"){
      _bodyview = new CampanhaDetail(_cartaofull);
      _titleview = 'Detalhes da Campanha';
    } else if(acao == "E"){
      _bodyview = new CampanhaExcluir(_cartaofull);
      _titleview = 'Excluir Campanha';
    } else if(acao == "C"){
      _bodyview = new CampanhaCancelar(_cartaofull);
      _titleview = 'Cancelar Campanha';
    } else if(acao == "S"){
      _bodyview = new CampanhaCashback(_cartaofull);
      _titleview = 'Cashback Campanha';
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text(_titleview),
      ),
      body: _bodyview,
      
    );
  }
}