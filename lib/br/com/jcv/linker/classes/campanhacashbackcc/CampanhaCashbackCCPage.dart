import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'CampanhaCashbackCCLV.dart';

class CampanhaCashbackCCPage extends StatefulWidget {
  int id_dono;

  CampanhaCashbackCCPage(this.id_dono);

  @override
  _CampanhaCashbackCCPageState createState() => _CampanhaCashbackCCPageState();
}

class _CampanhaCashbackCCPageState extends State<CampanhaCashbackCCPage> {

  String _token;
  String _urlControlador;
  int _dono;

  int _pag = 1;
  int _numdias = 7;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _dono = widget.id_dono;

  }

  Future<Map> _listCampanhaCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appListarMovimentoCashbackCC.php?tokenid=${_token}&dono=${_dono}&numdias=${_numdias}';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Extrato do Cashback"),
      ),

      body: FutureBuilder(
        future: _listCampanhaCashbackCC(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new CommonLoading();
            case ConnectionState.done:
              if(snapshot.hasError) {
              }
              if(snapshot.hasData){
                return CampanhaCashbackCCLV(snapshot.data);
              }
              break;
            default:
              return new Container(
                height: 0.0,
                width: 0.0,
              );
          }
        },
      ),
    );
  }
}
