// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.
class CartaoMoverHistoricoVOPost {
  final String tokenid;
  final String id;
  final String idCartao;
  final String idUsuarioDoador;
  final String idUsuarioReceptor;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe CartaoMoverHistoricoVOPost
  CartaoMoverHistoricoVOPost({this.tokenid, 
  this.id,
  this.idCartao,
  this.idUsuarioDoador,
  this.idUsuarioReceptor,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory CartaoMoverHistoricoVOPost.fromJson(Map<String, dynamic> json) {
    return CartaoMoverHistoricoVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      idCartao: json['idCartao'],
      idUsuarioDoador: json['idUsuarioDoador'],
      idUsuarioReceptor: json['idUsuarioReceptor'],
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
    map["idCartao"] = idCartao == null ? '' : idCartao;
    map["idUsuarioDoador"] = idUsuarioDoador == null ? '' : idUsuarioDoador;
    map["idUsuarioReceptor"] = idUsuarioReceptor == null ? '' : idUsuarioReceptor;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}

