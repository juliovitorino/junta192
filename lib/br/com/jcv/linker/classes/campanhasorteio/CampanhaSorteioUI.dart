import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

class CampanhaSorteioUI extends StatefulWidget {

  dynamic _campanhasorteioVO;

  CampanhaSorteioUI(this._campanhasorteioVO);

  @override
  _CampanhaSorteioUIState createState() => _CampanhaSorteioUIState();
}

class _CampanhaSorteioUIState extends State<CampanhaSorteioUI> {

  String _token;
  String _urlControlador;
  bool _isVisibleActionBtn = false;
  String _casoid;

  @override
  initState() {
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _casoid = widget._campanhasorteioVO['id'];
  }

//-------------------------------------------------------------------
// ativar a campanha para iniciar criação de tickets
//-------------------------------------------------------------------

  Future<Map> _ativarCampanhaSorteio() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appAtivarCampanhaSorteio.php?tokenid=$_token&casoid=$_casoid';
print(url);
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _ativarCampanhaSorteioClick() {

    CommonShowDialogYesNo ativarClick = CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.help, size: 120.0, color: Colors.blue), 
      textYes: "Sim",
      textNo: "Não",
      msg: "Deseja ATIVAR a campanha promocional?");

    ativarClick.showDialogYesNo().then((value) {
      if (ativarClick.getChoice() == "Y") {
        _ativarCampanhaSorteio().then((mapa) {
          CommonShowDialogYesNo msgretorno = CommonShowDialogYesNo (
            context: context,
            icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
            msg: mapa['msgcodeString']
          )..showDialogYesNo();
        });
      }

    });

  }

//-------------------------------------------------------------------
// usar a campanha para iniciar criação de tickets
//-------------------------------------------------------------------

  Future<Map> _usarCampanhaSorteio() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appUsarCampanhaSorteio.php?tokenid=$_token&casoid=$_casoid';
print(url);
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _usarCampanhaSorteioClick() {

    CommonShowDialogYesNo usarClick = CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.help, size: 120.0, color: Colors.blue), 
      textYes: "Sim",
      textNo: "Não",
      msg: "Deseja USAR a campanha promocional como principal?");

    usarClick.showDialogYesNo().then((value) {
      if (usarClick.getChoice() == "Y") {
        _usarCampanhaSorteio().then((mapa) {
          CommonShowDialogYesNo msgretorno = CommonShowDialogYesNo (
            context: context,
            icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
            msg: mapa['msgcodeString']
          )..showDialogYesNo();
        });
      }

    });

  }

//-------------------------------------------------------------------
// pausar a campanha para iniciar criação de tickets
//-------------------------------------------------------------------

  Future<Map> _pausarCampanhaSorteio() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appPausarCampanhaSorteio.php?tokenid=$_token&casoid=$_casoid';
print(url);
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _pausarCampanhaSorteioClick() {

    CommonShowDialogYesNo pausarClick = CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.help, size: 120.0, color: Colors.blue), 
      textYes: "Sim",
      textNo: "Não",
      msg: "Deseja PAUSAR a campanha promocional selecionada?");

    pausarClick.showDialogYesNo().then((value) {
      if (pausarClick.getChoice() == "Y") {
        _pausarCampanhaSorteio().then((mapa) {
          CommonShowDialogYesNo msgretorno = CommonShowDialogYesNo (
            context: context,
            icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
            msg: mapa['msgcodeString']
          )..showDialogYesNo();
        });
      }

    });

  }


//-------------------------------------------------------------------
// desativar a campanha sorteio definitivamente
//-------------------------------------------------------------------

  Future<Map> _desativarCampanhaSorteio() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appDesativarCampanhaSorteio.php?tokenid=$_token&casoid=$_casoid';
print(url);
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _desativarCampanhaSorteioClick() {

    CommonShowDialogYesNo pausarClick = CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.help, size: 120.0, color: Colors.blue), 
      textYes: "Sim",
      textNo: "Não",
      msg: "Deseja REALMENTE DESATIVAR a campanha promocional? Essa ação não poderá ser desfeita.");

    pausarClick.showDialogYesNo().then((value) {
      if (pausarClick.getChoice() == "Y") {
        _desativarCampanhaSorteio().then((mapa) {
          CommonShowDialogYesNo msgretorno = CommonShowDialogYesNo (
            context: context,
            icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
            msg: mapa['msgcodeString']
          )..showDialogYesNo();
        });
      }

    });

  }


//-------------------------------------------------------------------
// Apagar a campanha sorteio definitivamente
//-------------------------------------------------------------------

  Future<Map> _apagarCampanhaSorteio() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appApagarCampanhaSorteio.php?tokenid=$_token&casoid=$_casoid';
print(url);
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _apagarCampanhaSorteioClick() {

    CommonShowDialogYesNo apagarClick = CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.help, size: 120.0, color: Colors.blue), 
      textYes: "Sim",
      textNo: "Não",
      msg: "Deseja REALMENTE APAGAR a campanha promocional?");

    apagarClick.showDialogYesNo().then((value) {
      if (apagarClick.getChoice() == "Y") {
        _apagarCampanhaSorteio().then((mapa) {
          CommonShowDialogYesNo msgretorno = CommonShowDialogYesNo (
            context: context,
            icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
            msg: mapa['msgcodeString']
          )..showDialogYesNo();
        });
      }

    });

  }


  @override
  Widget build(BuildContext context) {

    String validade =  widget._campanhasorteioVO['dataComecoSorteio'] == null ? "Em aberto" : widget._campanhasorteioVO['dataComecoSorteio'] + " a " + widget._campanhasorteioVO['dataFimSorteio'];

    // monta dinamicamente os botoes de ação
    List<Widget> _lstBtnAcao = [];
    if(widget._campanhasorteioVO['status'] == "P") {
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.run_circle, color: Colors.white), "Ativar", (){
        _ativarCampanhaSorteioClick();
      }));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Apagar", (){
        _apagarCampanhaSorteioClick();
      }, color: Colors.red[800]));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}));
    }

    // campanha em status PRONTO PRA USO
    if(widget._campanhasorteioVO['status'] == "D") {
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.play_arrow, color: Colors.white), "Usar", (){
        _usarCampanhaSorteioClick();
      }, color: Colors.green[800]));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}));
    }

    // campanha em status ATIVO
    if(widget._campanhasorteioVO['status'] == "A") {
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.close, color: Colors.white), "Desativar", (){
        _desativarCampanhaSorteioClick();
      }, color: Colors.red[800]));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.pause, color: Colors.white), "Pausar", (){
        _pausarCampanhaSorteioClick();
      }));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}));
    }

    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _lstBtnAcao,
    );

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:8.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //new CommonImageCircle("no-user.png"
                    //    ,heightcic: 64
                    //    ,widthcic: 64
                    //    ,bordercolorcic: Colors.transparent),
                    //SizedBox(width: 8,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonDataItemTitleText("Campanha Promocional (" + widget._campanhasorteioVO['id']  + "/" + widget._campanhasorteioVO['maxTickets'] + ")",
                            widget._campanhasorteioVO['nome']),
                          CommonDataItemTitleText("Status", widget._campanhasorteioVO['statusdesc'].toUpperCase(), color: Colors.red[800]),
                          CommonDataItemTitleText("URL Regulamento", widget._campanhasorteioVO['urlRegulamento'], color: Colors.blue[800]),
                          CommonDataItemTitleText("Prêmio deste sorteio", widget._campanhasorteioVO['premio']),
                          CommonDataItemTitleText("Validade", validade),
                          //Text(widget._campanhasorteioVO['statusdesc'].toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.red)),
                          //,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['id_campanha'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['urlRegulamento'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataComecoSorteio'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataFimSorteio'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['maxTickets'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['status'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataCadastro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataAtualizacao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ),
                    IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                      setState(() {
                         _isVisibleActionBtn = !_isVisibleActionBtn;

                      });
                    },)
                  ],
                ),
                SizedBox(height: 10,),
                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,)
              ],
            ),
          ),
        )
    );
  }
}
