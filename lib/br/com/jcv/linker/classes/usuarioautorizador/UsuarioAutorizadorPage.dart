import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarioautorizador/UsuarioAutorizadorQRCodeIDClientePage.dart';

import 'UsuarioAutorizadorLV.dart';
import 'UsuarioAutorizadorPageCRUD.dart';
class UsuarioAutorizadorPage extends StatefulWidget {

  String campid;
  UsuarioAutorizadorPage(this.campid);

  @override
  _UsuarioAutorizadorPageState createState() => _UsuarioAutorizadorPageState();
}

class _UsuarioAutorizadorPageState extends State<UsuarioAutorizadorPage> {

  String _token;
  String _urlControlador;
  String _campid;

  int _pag = 1;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _campid = widget.campid;

  }

  Future<Map> _listUsuarioAutorizador() async {
    http.Response response;
    //String _url = '${_urlControlador}appListarUsuarioAutorizadorPorUsuaIdStatus.php?tokenid=${_token}&pag=${_pag}';
    String _url = '${_urlControlador}appListarUsuarioAutorizadorPorUsuaIdCampId.php?tokenid=${_token}&cmpid=${_campid}&pag=${_pag}';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Autorizar Colaboradores"),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new UsuarioAutorizadorQRCodeIDClientePage(_campid) ),
          );
        },
        child: Icon(Icons.add_circle_outline),
      ),


      body: FutureBuilder(
        future: _listUsuarioAutorizador(),
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
                return UsuarioAutorizadorLV(_campid, snapshot.data);
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

