// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

class CampanhaCashbackResgatePixVOPost {
  final String tokenid;
  final String id;
  final String idCampanhaCashback;
  final String idUsuarioSolicitante;
  final String tipoChavePix;
  final String chavePix;
  final String valorResgate;
  final String autenticacaoBco;
  final String estagioRealTime;
  final String dtEstagioAnalise;
  final String dtEstagioFinanceiro;
  final String dtEstagioErro;
  final String dtEstagioTranfBco;
  final String txtLivreEstagioRT;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe CampanhaCashbackResgatePixVOPost
  CampanhaCashbackResgatePixVOPost({this.tokenid, 
  this.id,
  this.idCampanhaCashback,
  this.idUsuarioSolicitante,
  this.tipoChavePix,
  this.chavePix,
  this.valorResgate,
  this.autenticacaoBco,
  this.estagioRealTime,
  this.dtEstagioAnalise,
  this.dtEstagioFinanceiro,
  this.dtEstagioErro,
  this.dtEstagioTranfBco,
  this.txtLivreEstagioRT,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory CampanhaCashbackResgatePixVOPost.fromJson(Map<String, dynamic> json) {
    return CampanhaCashbackResgatePixVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      idCampanhaCashback: json['idCampanhaCashback'],
      idUsuarioSolicitante: json['idUsuarioSolicitante'],
      tipoChavePix: json['tipoChavePix'],
      chavePix: json['chavePix'],
      valorResgate: json['valorResgate'],
      autenticacaoBco: json['autenticacaoBco'],
      estagioRealTime: json['estagioRealTime'],
      dtEstagioAnalise: json['dtEstagioAnalise'],
      dtEstagioFinanceiro: json['dtEstagioFinanceiro'],
      dtEstagioErro: json['dtEstagioErro'],
      dtEstagioTranfBco: json['dtEstagioTranfBco'],
      txtLivreEstagioRT: json['txtLivreEstagioRT'],
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
    map["idCampanhaCashback"] = idCampanhaCashback == null ? '' : idCampanhaCashback;
    map["idUsuarioSolicitante"] = idUsuarioSolicitante == null ? '' : idUsuarioSolicitante;
    map["tipoChavePix"] = tipoChavePix == null ? '' : tipoChavePix;
    map["chavePix"] = chavePix == null ? '' : chavePix;
    map["valorResgate"] = valorResgate == null ? '' : valorResgate;
    map["autenticacaoBco"] = autenticacaoBco == null ? '' : autenticacaoBco;
    map["estagioRealTime"] = estagioRealTime == null ? '' : estagioRealTime;
    map["dtEstagioAnalise"] = dtEstagioAnalise == null ? '' : dtEstagioAnalise;
    map["dtEstagioFinanceiro"] = dtEstagioFinanceiro == null ? '' : dtEstagioFinanceiro;
    map["dtEstagioErro"] = dtEstagioErro == null ? '' : dtEstagioErro;
    map["dtEstagioTranfBco"] = dtEstagioTranfBco == null ? '' : dtEstagioTranfBco;
    map["txtLivreEstagioRT"] = txtLivreEstagioRT == null ? '' : txtLivreEstagioRT;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}

