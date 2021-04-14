import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'dart:convert';

import 'package:junta192/br/com/jcv/linker/classes/ticket/cartoesLV.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class MeusCartoesFavoritosPage extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  MeusCartoesFavoritosPage({
    Key key,
    @required this.session
  }) : super(key: key);


  @override
  _MeusCartoesFavoritosPageState createState() => _MeusCartoesFavoritosPageState();
}

class _MeusCartoesFavoritosPageState extends State<MeusCartoesFavoritosPage> {

  String _token;
  String _urlControlador;
  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  Future<List> _listFavoritos() async {
    http.Response response;
    String _url = '${_urlControlador}appBuscarCartoesFavoritosCampanhaAtivo.php?tokenid=${_token}';
//    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listFavoritos() ,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new CommonLoading();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new CommonLoading();
          case ConnectionState.done:
            if(snapshot.hasError) {
              return new CommonLoading();
            }
            if(snapshot.hasData){
              return CartoesLV(snapshot.data);
            }
            break;
          default:
            return new Container(
              height: 0.0,
              width: 0.0,
            );
        }
      },
    );
  }
}