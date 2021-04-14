import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'CampanhaCashbackCCLV.dart';

class CampanhaCashbackCCDonoPage extends StatefulWidget {
  int id_usuario;

  CampanhaCashbackCCDonoPage(this.id_usuario);

  @override
  _CampanhaCashbackCCDonoPageState createState() => _CampanhaCashbackCCDonoPageState();
}

class _CampanhaCashbackCCDonoPageState extends State<CampanhaCashbackCCDonoPage> {

  String _token;
  String _urlControlador;
  int _id_usuario;

  int _pag = 1;
  int _numdias = 7;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _id_usuario = widget.id_usuario;

  }

  Future<Map> _listCampanhaCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appListarMovimentoCashbackCCDono.php?tokenid=${_token}&dono=${_id_usuario}&numdias=${_numdias}';

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
/*      
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new CampanhaCashbackCCDonoPageCRUD() ),
          );
        },
        child: Icon(Icons.add_circle_outline),
      ),
*/

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
