// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

class CampanhaSorteioVOPost {
  final String tokenid;
  final String id;
  final String idCampanha;
  final String nome;
  final String urlRegulamento;
  final String premio;
  final String dataInicioSorteio;
  final String dataFimSorteio;
  final String nuMaxTicketSorteio;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe CampanhaSorteioVOPost
  CampanhaSorteioVOPost({this.tokenid, 
  this.id,
  this.idCampanha,
  this.nome,
  this.urlRegulamento,
  this.premio,
  this.dataInicioSorteio,
  this.dataFimSorteio,
  this.nuMaxTicketSorteio,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory CampanhaSorteioVOPost.fromJson(Map<String, dynamic> json) {
    return CampanhaSorteioVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      idCampanha: json['idCampanha'],
      nome: json['nome'],
      urlRegulamento: json['urlRegulamento'],
      premio: json['premio'],
      dataInicioSorteio: json['dataInicioSorteio'],
      dataFimSorteio: json['dataFimSorteio'],
      nuMaxTicketSorteio: json['nuMaxTicketSorteio'],
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
    map["idCampanha"] = idCampanha == null ? '' : idCampanha;
    map["nome"] = nome == null ? '' : nome;
    map["urlRegulamento"] = urlRegulamento == null ? '' : urlRegulamento;
    map["premio"] = premio == null ? '' : premio;
    map["dataInicioSorteio"] = dataInicioSorteio == null ? '' : dataInicioSorteio;
    map["dataFimSorteio"] = dataFimSorteio == null ? '' : dataFimSorteio;
    map["nuMaxTicketSorteio"] = nuMaxTicketSorteio == null ? '' : nuMaxTicketSorteio;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
