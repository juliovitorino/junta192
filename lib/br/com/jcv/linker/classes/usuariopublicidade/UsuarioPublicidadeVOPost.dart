// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.
class UsuarioPublicidadeVOPost {
  String tokenid;
  String id;
  String id_usuario;
  String titulo;
  String descricao;
  String dataInicio;
  String dataTermino;
  String vlNormal;
  String vlNormalMoeda;
  String vlPromo;
  String vlPromoMoeda;
  String observacao;
  String dataRemover;
  String url;
  String modelo;
  String status;
  String dataCadastro;
  String dataAtualizacao;
  String msgcode;
  String msgcodeString;

/// Construtor da classe UsuarioPublicidadeVOPost
  UsuarioPublicidadeVOPost({this.tokenid, 
  this.id,
  this.id_usuario,
  this.titulo,
  this.descricao,
  this.dataInicio,
  this.dataTermino,
  this.vlNormal,
  this.vlNormalMoeda,
  this.vlPromo,
  this.vlPromoMoeda,
  this.url,
  this.modelo,
  this.observacao,
  this.dataRemover,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory UsuarioPublicidadeVOPost.fromJson(Map<String, dynamic> json) {
    return UsuarioPublicidadeVOPost(
      tokenid: json['tokenid'],
      id: json['id'].toString(),
      id_usuario: json['id_usuario'].toString(),
      titulo: json['titulo'],
      descricao: json['descricao'],
      dataInicio: json['dataInicio'],
      dataTermino: json['dataTermino'],
      vlNormal: json['vlNormal'].toString(),
      vlNormalMoeda: json['vlNormalMoeda'],
      vlPromo: json['vlPromo'].toString(),
      vlPromoMoeda: json['vlPromoMoeda'],
      observacao: json['observacao'],
      dataRemover: json['dataRemover'],
      url: json['url'],
      modelo: json['modelo'],
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
    map["id_usuario"] = id_usuario == null ? '' : id_usuario;
    map["titulo"] = titulo == null ? '' : titulo;
    map["descricao"] = descricao == null ? '' : descricao;
    map["dataInicio"] = dataInicio == null ? '' : dataInicio;
    map["dataTermino"] = dataTermino == null ? '' : dataTermino;
    map["vlNormal"] = vlNormal == null ? '' : vlNormal;
    map["vlPromo"] = vlPromo == null ? '' : vlPromo;
    map["observacao"] = observacao == null ? '' : observacao;
    map["dataRemover"] = dataRemover == null ? '' : dataRemover;
    map["url"] = url == null ? '' : url;
    map["modelo"] = modelo == null ? '' : modelo;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
