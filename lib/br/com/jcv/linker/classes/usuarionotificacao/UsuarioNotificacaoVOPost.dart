// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

import 'package:flutter/material.dart';

class UsuarioNotificacaoVOPost {
  final String tokenid;
  final String id;
  final String id_usuario;
  final String notificacao;
  final String icone;
  final String imagem;
  final String bkgcor;
  final String tipo;
  final String dataPrevApagar;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

  /// Construtor da classe UsuarioNotificacaoVOPost
  UsuarioNotificacaoVOPost({this.tokenid,
  this.id,
  this.id_usuario,
  this.notificacao,
  this.icone,
  this.imagem,
  this.bkgcor,
  this.tipo,
  this.dataPrevApagar,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='',
  this.msgcodeString=''});

  /// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory UsuarioNotificacaoVOPost.fromJson(Map<String, dynamic> json) {
    return UsuarioNotificacaoVOPost(
    tokenid: json['tokenid'],
    id: json['id'],
    id_usuario: json['id_usuario'],
    notificacao: json['notificacao'],
    icone: json['icone'],
    imagem: json['imagem'],
    bkgcor: json['bkgcor'],
    tipo: json['tipo'],
    dataPrevApagar: json['dataPrevApagar'],
    status: json['status'],
    dataCadastro: json['dataCadastro'],
    dataAtualizacao: json['dataAtualizacao'],

    msgcode: json['msgcode'],
    msgcodeString: json['msgcodeString'],
    );
    }
  /// Cria um mapa para ser enviado pelo método post da classe Http
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["tokenid"] = tokenid;
    map["id"] = id == null ? '' : id;
    map["id_usuario"] = id_usuario == null ? '' : id_usuario;
    map["notificacao"] = notificacao == null ? '' : notificacao;
    map["icone"] = icone == null ? '' : icone;
    map["imagem"] = imagem == null ? '' : imagem;
    map["bkgcor"] = bkgcor == null ? '' : bkgcor;
    map["tipo"] = tipo == null ? '' : tipo;
    map["dataPrevApagar"] = dataPrevApagar == null ? '' : dataPrevApagar;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
