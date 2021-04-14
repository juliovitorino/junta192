// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.
class CampanhaCashbackCCVOPost {
  final String tokenid;
  final String id;
  final String id_cashback;
  final String id_campanha;
  final String id_usuario;
  final String id_dono;
  final String id_cfdi;
  final String descricao;
  final String vlMinimo;
  final String percentual;
  final String vlConsumo;
  final String vlCalcRecompensa;
  final String tipoMovimento;
  final String nfe;
  final String nfehash;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe CampanhaCashbackCCVOPost
  CampanhaCashbackCCVOPost({this.tokenid, 
  this.id,
  this.id_cashback,
  this.id_campanha,
  this.id_usuario,
  this.id_dono,
  this.id_cfdi,
  this.descricao,
  this.vlMinimo,
  this.percentual,
  this.vlConsumo,
  this.vlCalcRecompensa,
  this.tipoMovimento,
  this.nfe,
  this.nfehash,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory CampanhaCashbackCCVOPost.fromJson(Map<String, dynamic> json) {
    return CampanhaCashbackCCVOPost(
      tokenid: json['tokenid'],
      id: json['id'],
      id_cashback: json['id_cashback'],
      id_campanha: json['id_campanha'],
      id_usuario: json['id_usuario'],
      id_dono: json['id_dono'],
      id_cfdi: json['id_cfdi'],
      descricao: json['descricao'],
      vlMinimo: json['vlMinimo'],
      percentual: json['percentual'],
      vlConsumo: json['vlConsumo'],
      vlCalcRecompensa: json['vlCalcRecompensa'],
      tipoMovimento: json['tipoMovimento'],
      nfe: json['nfe'],
      nfehash: json['nfehash'],
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
    map["id_cashback"] = id_cashback == null ? '' : id_cashback;
    map["id_campanha"] = id_campanha == null ? '' : id_campanha;
    map["id_usuario"] = id_usuario == null ? '' : id_usuario;
    map["id_dono"] = id_dono == null ? '' : id_dono;
    map["id_cfdi"] = id_cfdi == null ? '' : id_cfdi;
    map["descricao"] = descricao == null ? '' : descricao;
    map["vlMinimo"] = vlMinimo == null ? '' : vlMinimo;
    map["percentual"] = percentual == null ? '' : percentual;
    map["vlConsumo"] = vlConsumo == null ? '' : vlConsumo;
    map["vlCalcRecompensa"] = vlCalcRecompensa == null ? '' : vlCalcRecompensa;
    map["tipoMovimento"] = tipoMovimento == null ? '' : tipoMovimento;
    map["nfe"] = nfe == null ? '' : nfe;
    map["nfehash"] = nfehash == null ? '' : nfehash;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
