import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'UsuarioCampanhaSorteioTicketLV.dart';
import 'UsuarioCampanhaSorteioTicketPageCRUD.dart';
class UsuarioCampanhaSorteioTicketPage extends StatefulWidget {

  dynamic mapUsuarioSorteioTicket;

  UsuarioCampanhaSorteioTicketPage(this.mapUsuarioSorteioTicket, {Key key }) : super(key: key);

  @override
  _UsuarioCampanhaSorteioTicketPageState createState() => _UsuarioCampanhaSorteioTicketPageState();
}

class _UsuarioCampanhaSorteioTicketPageState extends State<UsuarioCampanhaSorteioTicketPage> {

  String _token;
  String _urlControlador;

  int _pag = 1;
  String _ucstid= "";

  @override
  _UsuarioCampanhaSorteioTicketPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _ucstid = widget.mapUsuarioSorteioTicket['id'];

  }

  Future<Map> _listUsuarioCampanhaSorteioTicket() async {
    http.Response response;
    String _url = '${_urlControlador}appListarUsuarioCampanhaSorteioTicketPorUcstId.php?tokenid=$_token&ucstid=$_ucstid&pag=$_pag';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Meus Bilhetes"),
      ),

      body: FutureBuilder(
        future: _listUsuarioCampanhaSorteioTicket(),
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
                return UsuarioCampanhaSorteioTicketLV(snapshot.data);
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
