





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'RegistroIndicacaoLV.dart';
import 'RegistroIndicacaoPageCRUD.dart';
class RegistroIndicacaoPage extends StatefulWidget {

  @override
  _RegistroIndicacaoPageState createState() => _RegistroIndicacaoPageState();
}

class _RegistroIndicacaoPageState extends State<RegistroIndicacaoPage> {

  String _token;
  String _urlControlador;

  int _pag = 1;

  @override
  _RegistroIndicacaoPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];

  }

  Future<Map> _listRegistroIndicacao() async {
    http.Response response;
    String _url = '${_urlControlador}appListarRegistroIndicacaoPorUsuaIdStatus.php?tokenid=${_token}&pag=${_pag}';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("RegistroIndicacao"),
      ),
floatingActionButton: new FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new RegistroIndicacaoPageCRUD() ),
    );
  },
  child: Icon(Icons.add_circle_outline),
),


      body: FutureBuilder(
        future: _listRegistroIndicacao(),
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
                return RegistroIndicacaoLV(snapshot.data);
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

















































































































































































































































