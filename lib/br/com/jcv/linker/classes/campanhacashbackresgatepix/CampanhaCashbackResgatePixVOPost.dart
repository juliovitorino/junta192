// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

class CampanhaCashbackResgatePixVOPost {
  final String tokenid;
  final String id;
  final String idUsuarioDevedor;
  final String idUsuarioSolicitante;
  final String tipoChavePix;
  final String tipoChavePixDesc;
  final String chavePix;
  final String valorResgate;
  final String valorResgateCurrency;
  final String autenticacaoBco;
  final String estagioRealTime;
  final String estagioRealTimeDesc;
  final String dtEstagioAnalise;
  final String dtEstagioFinanceiro;
  final String dtEstagioErro;
  final String dtEstagioTranfBco;
  final String txtLivreEstagioRT;
  final String status;
  final String statusDesc;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe CampanhaCashbackResgatePixVOPost
  CampanhaCashbackResgatePixVOPost({this.tokenid, 
  this.id,
  this.idUsuarioDevedor,
  this.idUsuarioSolicitante,
  this.tipoChavePix,
  this.tipoChavePixDesc,
  this.chavePix,
  this.valorResgate,
  this.valorResgateCurrency,
  this.autenticacaoBco,
  this.estagioRealTime,
  this.estagioRealTimeDesc,
  this.dtEstagioAnalise,
  this.dtEstagioFinanceiro,
  this.dtEstagioErro,
  this.dtEstagioTranfBco,
  this.txtLivreEstagioRT,
  this.status,
  this.statusDesc,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory CampanhaCashbackResgatePixVOPost.fromJson(Map<String, dynamic> json) {
    return CampanhaCashbackResgatePixVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      idUsuarioDevedor: json['idUsuarioDevedor'],
      idUsuarioSolicitante: json['idUsuarioSolicitante'],
      tipoChavePix: json['tipoChavePix'],
      tipoChavePixDesc: json['tipoChavePixDesc'],
      chavePix: json['chavePix'],
      valorResgate: json['valorResgate'].toString(),
      valorResgateCurrency: json['valorResgateCurrency'],
      autenticacaoBco: json['autenticacaoBco'] == null ? '' : json['autenticacaoBco'],
      estagioRealTime: json['estagioRealTime'],
      estagioRealTimeDesc: json['estagioRealTimeDesc'],
      dtEstagioAnalise: json['dtEstagioAnalise'] == null ? '' : json['dtEstagioAnalise'],
      dtEstagioFinanceiro:  json['dtEstagioFinanceiro'] == null ? '' : json['dtEstagioFinanceiro'],
      dtEstagioErro: json['dtEstagioErro'] == null ? '' : json['dtEstagioErro'],
      dtEstagioTranfBco: json['dtEstagioTranfBco'] == null ? '' : json['dtEstagioTranfBco'],
      txtLivreEstagioRT: json['txtLivreEstagioRT'] == null ? '' : json['txtLivreEstagioRT'],
      status: json['status'],
      statusDesc: json['statusDesc'],
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
    map["idUsuarioDevedor"] = idUsuarioDevedor == null ? '' : idUsuarioDevedor;
    map["idUsuarioSolicitante"] = idUsuarioSolicitante == null ? '' : idUsuarioSolicitante;
    map["tipoChavePix"] = tipoChavePix == null ? '' : tipoChavePix;
    map["tipoChavePixDesc"] = tipoChavePixDesc == null ? '' : tipoChavePixDesc;
    map["chavePix"] = chavePix == null ? '' : chavePix;
    map["valorResgate"] = valorResgate == null ? '' : valorResgate;
    map["valorResgateCurrency"] = valorResgateCurrency == null ? '' : valorResgateCurrency;
    map["autenticacaoBco"] = autenticacaoBco == null ? '' : autenticacaoBco;
    map["estagioRealTime"] = estagioRealTime == null ? '' : estagioRealTime;
    map["estagioRealTimeDesc"] = estagioRealTimeDesc == null ? '' : estagioRealTimeDesc;
    map["dtEstagioAnalise"] = dtEstagioAnalise == null ? '' : dtEstagioAnalise;
    map["dtEstagioFinanceiro"] = dtEstagioFinanceiro == null ? '' : dtEstagioFinanceiro;
    map["dtEstagioErro"] = dtEstagioErro == null ? '' : dtEstagioErro;
    map["dtEstagioTranfBco"] = dtEstagioTranfBco == null ? '' : dtEstagioTranfBco;
    map["txtLivreEstagioRT"] = txtLivreEstagioRT == null ? '' : txtLivreEstagioRT;
    map["status"] = status == null ? '' : status;
    map["statusDesc"] = statusDesc == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}

