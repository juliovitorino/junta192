// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.
class CampanhaCashbackVOPost {
  final String tokenid;
  final String id;
  final String id_usca;
  final String id_campanha;
  final String id_usuario;
  final String percentual;
  final String percentualFmt;
  final String dataTermino;
  final String obs;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe CampanhaCashbackVOPost
  CampanhaCashbackVOPost({this.tokenid, 
  this.id,
  this.id_usca,
  this.id_campanha,
  this.id_usuario,
  this.percentual,
  this.percentualFmt,
  this.dataTermino,
  this.obs,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory CampanhaCashbackVOPost.fromJson(Map<String, dynamic> json) {
    return CampanhaCashbackVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      id_usca: json['id_usca'],
      id_campanha: json['id_campanha'],
      id_usuario: json['id_usuario'],
      percentual: json['percentual'],
      percentualFmt: json['percentualFmt'],
      dataTermino: json['dataTermino'],
      obs: json['obs'],
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
    map["id_usca"] = id_usca == null ? '' : id_usca;
    map["id_campanha"] = id_campanha == null ? '' : id_campanha;
    map["id_usuario"] = id_usuario == null ? '' : id_usuario;
    map["percentual"] = percentual == null ? '' : percentual;
    map["percentualFmt"] = percentualFmt == null ? '' : percentualFmt;
    map["dataTermino"] = dataTermino == null ? '' : dataTermino;
    map["obs"] = obs == null ? '' : obs;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
