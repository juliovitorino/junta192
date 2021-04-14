import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'dart:convert';

import 'package:junta192/br/com/jcv/linker/classes/ticket/cartoesLV.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class MeusCartoesDigitaisPage extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  MeusCartoesDigitaisPage({
    Key key, 
    @required this.session
  }) : super(key: key);


  @override
  _MeusCartoesDigitaisPageState createState() => _MeusCartoesDigitaisPageState();
}

class _MeusCartoesDigitaisPageState extends State<MeusCartoesDigitaisPage> {

  String _token;
  String _urlControlador;
  
  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  Future<List> _listCartoes10M() async {
    http.Response response;
    String _url = '${_urlControlador}appBuscarCartoesCampanhaAtivo10M.php?tokenid=${_token}';
//    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  Future<List> _listCartoes() async {
    http.Response response;
    String _url = '${_urlControlador}appBuscarCartoesCampanhaAtivo.php?tokenid=${_token}';
    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  Future<List> _listCartoesCompletos() async {
    http.Response response;
    String _url = '${_urlControlador}appBuscarCartoesCompleto.php?tokenid=${_token}';
//    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  Future<List> _listCartoesEmResgate() async {
    http.Response response;
    String _url = '${_urlControlador}appBuscarCartoesProcessoResgate.php?tokenid=${_token}';
//    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4C3),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.replay_10),
                  Text("+Recente", style: TextStyle(fontSize: 12.0),),
                  SizedBox(height: 8.0,)
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.credit_card),
                  Text("Em aberto", style: TextStyle(fontSize: 12.0),),
                  SizedBox(height: 8.0,)
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.check),
                  Text("Completo", style: TextStyle(fontSize: 12.0),),
                  SizedBox(height: 8.0,)
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.all_inclusive),
                  Text("Resgate", style: TextStyle(fontSize: 12.0),),
                  SizedBox(height: 8.0,)
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder(
              future: _listCartoes10M() ,
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
            ),
            FutureBuilder(
              future: _listCartoes(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
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
            ),
            FutureBuilder(
              future: _listCartoesCompletos(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
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
            ),
            FutureBuilder(
              future: _listCartoesEmResgate(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
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
            ),
          ],
        ),
      ),
    );
  }
}