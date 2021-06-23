import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'UsuarioCampanhaSorteioLV.dart';
//import 'UsuarioCampanhaSorteioPageCRUD.dart';
class UsuarioCampanhaSorteioPage extends StatefulWidget {

  @override
  _UsuarioCampanhaSorteioPageState createState() => _UsuarioCampanhaSorteioPageState();
}

class _UsuarioCampanhaSorteioPageState extends State<UsuarioCampanhaSorteioPage> {

  String _token;
  String _urlControlador;

  int _pag = 1;

  @override
  _UsuarioCampanhaSorteioPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];

  }

  Future<Map> _listUsuarioCampanhaSorteio() async {
    http.Response response;
    String _url = '${_urlControlador}appListarUsuarioCampanhaSorteioPorUsuaIdStatus.php?tokenid=$_token&pag=$_pag';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: FutureBuilder(
        future: _listUsuarioCampanhaSorteio(),
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
                return UsuarioCampanhaSorteioLV(snapshot.data);
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
