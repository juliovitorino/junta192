// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

class PlanoVOPost {
  final String tokenid;
  final String id;
  final String nome;
  final String permissao;
  final String valor;
  final String valorMoeda;
  final String tipo;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe PlanoVOPost
  PlanoVOPost({this.tokenid, 
  this.id,
  this.nome,
  this.permissao,
  this.valor,
  this.valorMoeda,
  this.tipo,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory PlanoVOPost.fromJson(Map<String, dynamic> json) {
    return PlanoVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      nome: json['nome'],
      permissao: json['permissao'],
      valor: json['valor'],
      valorMoeda: json['valorMoeda'],
      tipo: json['tipo'],
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
    map["nome"] = nome == null ? '' : nome;
    map["permissao"] = permissao == null ? '' : permissao;
    map["valor"] = valor == null ? '' : valor;
    map["valorMoeda"] = valorMoeda == null ? '' : valor;
    map["tipo"] = tipo == null ? '' : tipo;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}














































































