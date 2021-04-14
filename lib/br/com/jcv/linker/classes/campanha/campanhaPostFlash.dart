import 'package:flutter/material.dart';

class CampanhaFlashPost {
  final String tokenid;
  final String idcamp;
  final String nome;
  final String regras;
  final String dataInicio;
  final String dataTermino;
  final String limMaxSelos;
  final String recompensa;
  final String fraseAgradecimento;
  final String fraseEfeito;
  final String vlticket;
  final String msgcode;
  final String msgcodeString;
 
  CampanhaFlashPost({this.tokenid, 
  this.idcamp='0',
  this.nome='', 
  this.regras='',
  this.dataInicio='',
  this.dataTermino='',
  this.limMaxSelos='0',
  this.recompensa='', 
  this.fraseAgradecimento='',
  this.fraseEfeito='',
  this.vlticket='0.00',
  this.msgcode='', 
  this.msgcodeString=''});
 
  factory CampanhaFlashPost.fromJson(Map<String, dynamic> json) {
    return CampanhaFlashPost(
      tokenid: json['tokenid'],
      idcamp: json['idcamp'],
      nome: json['nome'],
      regras: json['regras'],
      dataInicio: json['dataInicio'],
      dataTermino: json['dataTermino'],
      limMaxSelos: json['limMaxSelos'],
      recompensa: json['recompensa'],
      fraseAgradecimento: json['fraseAgradecimento'],
      fraseEfeito: json['fraseEfeito'],
      vlticket: json['vlticket'],
      msgcode: json['msgcode'],
      msgcodeString: json['msgcodeString'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["tokenid"] = tokenid;
    map["idcamp"] = idcamp;
    map["nome"] = nome;
    map["regras"] = regras;
    map["dataInicio"] = dataInicio;
    map["dataTermino"] = dataTermino;
    map["limMaxSelos"] = limMaxSelos;
    map["recompensa"] = recompensa;
    map["fraseAgradecimento"] = fraseAgradecimento;
    map["fraseEfeito"] = fraseEfeito;
    map["vlticket"] = vlticket;
    return map;
  }
}