// Copyright (c) 2019 Julio Vitorino. Todos os direitos reservados.

//===========================================================
//
// #####  #     #   ###   ######     #    ######   ##### 
//#     # #     #    #    #     #   # #   #     # #     #
//#       #     #    #    #     #  #   #  #     # #     #
//#       #     #    #    #     # #     # #     # #     #
//#       #     #    #    #     # ####### #     # #     #
//#     # #     #    #    #     # #     # #     # #     #
// #####   #####    ###   ######  #     # ######   #####
// 
//===========================================================
//CÓDIGO SOFREU ALTERAÇÕES PROFUNDAS, NÃO USE O GERADOR
//AUTOMÁTICO PARA SUBSTITUIR O CÓDIGO AQUI EXISTENTE.
//TODO O SISTEMA PODE ENTRAR EM COLAPSO.
//===========================================================
//***********************************************************/ 

class UsuarioAutorizadorVOPost {
  final String tokenid;
  final String id;
  final String id_usuario;
  final String id_autorizador;
  final String id_campanha;
  final String tipo;
  final String tipostr;
  final String permissao;
  final String permissaostr;
  final String dataInicio;
  final String dataTermino;
  final String onoff;
  final String status;
  final String dataCadastro;
  final String dataAtualizacao;
  final String msgcode;
  final String msgcodeString;

/// Construtor da classe UsuarioAutorizadorVOPost
  UsuarioAutorizadorVOPost({this.tokenid, 
  this.id,
  this.id_usuario,
  this.id_autorizador,
  this.id_campanha,
  this.tipo,
  this.tipostr,
  this.permissao,
  this.permissaostr,
  this.dataInicio,
  this.dataTermino,
  this.onoff,
  this.status,
  this.dataCadastro,
  this.dataAtualizacao,
  this.msgcode='', 
  this.msgcodeString=''});

/// Retorno do Backend devolvendo um JSON na estrutura de campos abaixo
  factory UsuarioAutorizadorVOPost.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return UsuarioAutorizadorVOPost(
      tokenid: json['tokenid'],
      id: json['id'].toString(),
      id_usuario: json['id_usuario'.toString()],
      id_autorizador: json['id_autorizador'].toString(),
      id_campanha: json['id_campanha'].toString(),
      tipo: json['tipo'],
      tipostr: json['tipostr'],
      permissao: json['permissao'],
      permissaostr: json['permissaostr'],
      dataInicio: json['dataInicio'],
      dataTermino: json['dataTermino'],
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
    map["id_usuario"] = id_usuario == null ? '' : id_usuario.toString();
    map["id_autorizador"] = id_autorizador == null ? '' : id_autorizador.toString();
    map["id_campanha"] = id_campanha == null ? '' : id_campanha.toString();
    map["tipo"] = tipo == null ? '' : tipo;
    map["tipostr"] = tipostr == null ? '' : tipostr;
    map["permissao"] = permissao == null ? '' : permissao;
    map["permissaostr"] = permissaostr == null ? '' : permissaostr;
    map["dataInicio"] = dataInicio == null ? '' : dataInicio;
    map["dataTermino"] = dataTermino == null ? '' : dataTermino;
    map["onoff"] = onoff == null ? '' : onoff;
    map["status"] = status == null ? '' : status;
    map["dataCadastro"] = dataCadastro == null ? '' : dataCadastro;
    map["dataAtualizacao"] = dataAtualizacao == null ? '' : dataAtualizacao;

    return map;
  }
}
