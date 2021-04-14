// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

class UsuarioCashbackVOPost {
  final String tokenid;
  final String id;
  final String id_usuario;
  final String vlMinimoResgate;
  final String percentual;
  final String vlMinimoResgateMoeda;
  final String percentualFmt;
  final String obs;
  final String contadorStar_1;
  final String contadorStar_2;
  final String contadorStar_3;
  final String contadorStar_4;
  final String contadorStar_5;
  final String ratingCalculado;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe UsuarioCashbackVOPost
  UsuarioCashbackVOPost({this.tokenid, 
  this.id,
  this.id_usuario,
  this.vlMinimoResgate,
  this.percentual,
  this.vlMinimoResgateMoeda,
  this.percentualFmt,
  this.obs,
  this.contadorStar_1,
  this.contadorStar_2,
  this.contadorStar_3,
  this.contadorStar_4,
  this.contadorStar_5,
  this.ratingCalculado,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory UsuarioCashbackVOPost.fromJson(Map<String, dynamic> json) {
    return UsuarioCashbackVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      id_usuario: json['id_usuario'],
      vlMinimoResgate: json['vlMinimoResgate'],
      percentual: json['percentual'],
      vlMinimoResgateMoeda: json['vlMinimoResgateMoeda'],
      percentualFmt: json['percentualFmt'],
      obs: json['obs'],
      contadorStar_1: json['contadorStar_1'],
      contadorStar_2: json['contadorStar_2'],
      contadorStar_3: json['contadorStar_3'],
      contadorStar_4: json['contadorStar_4'],
      contadorStar_5: json['contadorStar_5'],
      ratingCalculado: json['ratingCalculado'],
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
    map["id"] = id == null ? '' : id.toString();
    map["id_usuario"] = id_usuario == null ? '' : id_usuario.toLowerCase();
    map["vlMinimoResgate"] = vlMinimoResgate == null ? '' : vlMinimoResgate.toString();
    map["percentual"] = percentual.toString();
    map["obs"] = obs == null ? '' : obs;
    map["contadorStar_1"] = contadorStar_1 == null ? '' : contadorStar_1;
    map["contadorStar_2"] = contadorStar_2 == null ? '' : contadorStar_2;
    map["contadorStar_3"] = contadorStar_3 == null ? '' : contadorStar_3;
    map["contadorStar_4"] = contadorStar_4 == null ? '' : contadorStar_4;
    map["contadorStar_5"] = contadorStar_5 == null ? '' : contadorStar_5;
    map["ratingCalculado"] = ratingCalculado == null ? '' : ratingCalculado;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
