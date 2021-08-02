import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'CampanhaCashbackResgatePixLV.dart';
import 'CampanhaCashbackResgatePixPageCRUD.dart';

class CampanhaCashbackResgatePixPage extends StatefulWidget {

  dynamic _saldoCashbackCCVO;

  CampanhaCashbackResgatePixPage(this._saldoCashbackCCVO);

  @override
  _CampanhaCashbackResgatePixPageState createState() => _CampanhaCashbackResgatePixPageState();
}

class _CampanhaCashbackResgatePixPageState extends State<CampanhaCashbackResgatePixPage> {

  String _token;
  String _urlControlador;
  String _usuaid_devedor;

  int _pag = 1;

  @override
  _CampanhaCashbackResgatePixPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _usuaid_devedor = widget._saldoCashbackCCVO['id_dono'];

  }

  Future<Map> _listCampanhaCashbackResgatePix() async {
    http.Response response;
    String _url = '${_urlControlador}appListarCampanhaCashbackResgatePixPorUsuaIdUsuaIdDevedorStatus.php?tokenid=$_token&usuaidDevedor=$_usuaid_devedor&pag=$_pag';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CampanhaCashbackResgatePix"),
      ),
floatingActionButton: new FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new CampanhaCashbackResgatePixPageCRUD(widget._saldoCashbackCCVO) ),
    );
  },
  child: Icon(Icons.add_circle_outline),
),


      body: FutureBuilder(
        future: _listCampanhaCashbackResgatePix(),
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
                return CampanhaCashbackResgatePixLV(snapshot.data);
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

