import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/campanhacashback/CampanhaCashbackVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'CampanhaCashbackLV.dart';
import 'CampanhaCashbackPageCRUD.dart';

class CampanhaCashbackPage extends StatefulWidget {
  int idcampanha;

  CampanhaCashbackPage(this.idcampanha);

  @override
  _CampanhaCashbackPageState createState() => _CampanhaCashbackPageState();
}

class _CampanhaCashbackPageState extends State<CampanhaCashbackPage> {

  String _token;
  String _urlControlador;

  int _pag = 1;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";

  }

  Future<Map> _listCampanhaCashback() async {
    http.Response response;
    String _url = '${_urlControlador}appListarCampanhaCashbackPorUsuaIdStatus.php?tokenid=$_token&pag=$_pag';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cashback da Campanha"),
      ),
floatingActionButton: new FloatingActionButton(
  onPressed: () {
    CampanhaCashbackVOPost vo = new CampanhaCashbackVOPost(id: '0', id_campanha: widget.idcampanha.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new CampanhaCashbackPageCRUD(campanhacashbackVO: vo) ),
    );
  },
  child: Icon(Icons.add_circle_outline),
),


      body: FutureBuilder(
        future: _listCampanhaCashback(),
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
                return CampanhaCashbackLV(snapshot.data);
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
