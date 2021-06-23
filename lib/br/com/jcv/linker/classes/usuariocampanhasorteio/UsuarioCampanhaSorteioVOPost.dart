// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

class UsuarioCampanhaSorteioVOPost {
  final String tokenid;
  final String id;
  final String idUsuario;
  final String idCampanhaSorteio;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe UsuarioCampanhaSorteioVOPost
  UsuarioCampanhaSorteioVOPost({this.tokenid, 
  this.id,
  this.idUsuario,
  this.idCampanhaSorteio,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory UsuarioCampanhaSorteioVOPost.fromJson(Map<String, dynamic> json) {
    return UsuarioCampanhaSorteioVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      idUsuario: json['idUsuario'],
      idCampanhaSorteio: json['idCampanhaSorteio'],
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
    map["idUsuario"] = idUsuario == null ? '' : idUsuario;
    map["idCampanhaSorteio"] = idCampanhaSorteio == null ? '' : idCampanhaSorteio;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
