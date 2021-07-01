
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

const String glsArquivo = "assets/config/global-startup.json";
const String glsAmbienteAtivo = 'ambienteAtivo';
const String glsAmbientesDisponiveis = 'ambientesDisponiveis';
const String glsProducao = 'PRD';
const String glsHomologacao = 'HMG';
const String glsDesenvolvimento = 'DSV';
const String glsAmbienteItem = 'ambiente';
const String glsGateway = 'gateway';
const String glsGatewaySSL = 'gatewayssl';
const String glsVersao = 'versao';
const String glsUpload = 'upload';
const String glsErro = "Erro ao capturar ";
const String glsHome = "home";
const String glsHomeimg = "homeimg";
const String glswhatsappSuporteNumero = "whatsappSuporteNumero";
const String glswhatsappSuporteMsg = "whatsappSuporteMsg";

/// GlobalStartup
/// 
/// Iniciar um singleton com as configurações base do aplicativo
/// 
/// Julio Vitorino, 2019
/// 
class GlobalStartup {
  static final GlobalStartup _singleton = new GlobalStartup._internal();

  Map _jsonsession;

  factory GlobalStartup() {
    return _singleton;
  }

  GlobalStartup._internal()  {
print("GlobalStartup._internal() => 1")    ;
    _getFileData().then((jsonmap){
print("GlobalStartup._internal() => 2")    ;
      this._jsonsession = json.decode(jsonmap);
    });
  }

  Future<String> _getFileData() async {
print("GlobalStartup._internal() => 3")    ;
    return await rootBundle.loadString(glsArquivo);
  }

  String getAmbienteAtivo() {
    return _jsonsession[glsAmbienteAtivo];
  }
  
  String getWhatsappSuporteNumero() {
    return _jsonsession[glswhatsappSuporteNumero];
  }

  String getwhatsappSuporteMsg() {
    return _jsonsession[glswhatsappSuporteMsg];
  }

  // Retorna um Array Cotendo o ambiente ativo
  String getGateway() {
print("GlobalStartup._internal() => 4")    ;
    String gateway = glsErro + glsGateway;
    for (var glsItem in _jsonsession[glsAmbientesDisponiveis]) {
      if(glsItem[glsAmbienteItem] == _jsonsession[glsAmbienteAtivo]){
        gateway = glsItem[glsGateway];
        break;
      }
    }
    return gateway;
  }

  // Retorna um Array Cotendo o ambiente ativo
  String getGatewaySsl() {
print("GlobalStartup._internal() => 8")    ;
    String gateway = glsErro + glsGatewaySSL;
    for (var glsItem in _jsonsession[glsAmbientesDisponiveis]) {
      if(glsItem[glsAmbienteItem] == _jsonsession[glsAmbienteAtivo]){
        gateway = glsItem[glsGatewaySSL];
        break;
      }
    }
    return gateway;
  }

  String getVersao() {
print("GlobalStartup._internal() => 5")    ;
    String versao = glsErro + glsVersao;
    for (var glsItem in _jsonsession[glsAmbientesDisponiveis]) {
      if(glsItem[glsAmbienteItem] == _jsonsession[glsAmbienteAtivo]){
        versao = glsItem[glsVersao];
        break;
      }
    }
    return versao;
  }

  String getVersaoMin() {
    List<String> versao = getVersao().split(".");
    return versao[0] + "." + versao[1] + "." + versao[2];
  }

  String getUpload() {
print("GlobalStartup._internal() => 6")    ;
    String upload = glsErro + glsUpload;
    for (var glsItem in _jsonsession[glsAmbientesDisponiveis]) {
      if(glsItem[glsAmbienteItem] == _jsonsession[glsAmbienteAtivo]){
        upload = glsItem[glsUpload];
        break;
      }
    }
    return upload;
  }

  String getHome() {
print("GlobalStartup._internal() => 1532")    ;
    String home = glsErro + glsHome;
    for (var glsItem in _jsonsession[glsAmbientesDisponiveis]) {
      if(glsItem[glsAmbienteItem] == _jsonsession[glsAmbienteAtivo]){
        home = glsItem[glsHome];
        break;
      }
    }
print("GlobalStartup atributo home " + home);    
    return home;
  }


  String getHomeImg() {
print("GlobalStartup._internal() => 1532")    ;
    String homeimg = glsErro + glsHomeimg;
    for (var glsItem in _jsonsession[glsAmbientesDisponiveis]) {
      if(glsItem[glsAmbienteItem] == _jsonsession[glsAmbienteAtivo]){
        homeimg = glsItem[glsHomeimg];
        break;
      }
    }
print("GlobalStartup atributo home " + homeimg);    
    return homeimg;
  }



}