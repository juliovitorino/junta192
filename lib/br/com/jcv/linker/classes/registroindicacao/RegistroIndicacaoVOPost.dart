// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.
class RegistroIndicacaoVOPost {
  final String tokenid;
  final String id;
  final String idUsuarioPromotor;
  final String idUsuarioIndicado;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe RegistroIndicacaoVOPost
  RegistroIndicacaoVOPost({this.tokenid, 
  this.id,
  this.idUsuarioPromotor,
  this.idUsuarioIndicado,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory RegistroIndicacaoVOPost.fromJson(Map<String, dynamic> json) {
    return RegistroIndicacaoVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      idUsuarioPromotor: json['idUsuarioPromotor'],
      idUsuarioIndicado: json['idUsuarioIndicado'],
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
    map["idUsuarioPromotor"] = idUsuarioPromotor == null ? '' : idUsuarioPromotor;
    map["idUsuarioIndicado"] = idUsuarioIndicado == null ? '' : idUsuarioIndicado;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
