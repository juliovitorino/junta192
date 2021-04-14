import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'UsuarioNotificacaoLV.dart';

class UsuarioNotificacaoContainer extends StatefulWidget {

  @override
  _UsuarioNotificacaoContainerState createState() => _UsuarioNotificacaoContainerState();
}

class _UsuarioNotificacaoContainerState extends State<UsuarioNotificacaoContainer> {

  String _token;
  String _urlControlador;

  int _pag = 1;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";

  }

  Future<Map> _listUsuarioNotificacao() async {
    http.Response response;
    String _url = '${_urlControlador}appListarUsuarioNotificacaoPorUsuaIdStatus.php?tokenid=${_token}&pag=${_pag}';
    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _listUsuarioNotificacao(),
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
              return UsuarioNotificacaoLV(snapshot.data);
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
