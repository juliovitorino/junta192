import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'campanhaParticipantesLV.dart';

class CampanhaParticipantesPage extends StatefulWidget {

  dynamic cartaofull;

  CampanhaParticipantesPage(this.cartaofull);

  @override
  _CampanhaParticipantesPageState createState() => _CampanhaParticipantesPageState();
}

class _CampanhaParticipantesPageState extends State<CampanhaParticipantesPage> {

  String _token;
  String _urlControlador;
  String _campid;
  int _pag = 1;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _campid = widget.cartaofull['id'];
  }

  Future<Map> _listCartoes() async {
    http.Response response;
    String _url = '${_urlControlador}appListarCampanhaParticipantes.php?tokenid=$_token&campid=$_campid&pag=$_pag';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Participantes"),
      ),
      body: FutureBuilder(
        future: _listCartoes(),
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
                return CampanhaParticipantesLV(snapshot.data);
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