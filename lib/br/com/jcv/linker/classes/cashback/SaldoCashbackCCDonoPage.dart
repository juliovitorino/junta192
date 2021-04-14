import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/cashback/SaldoCashbackCCDonoLV.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';


class SaldoCashbackCCDonoPage extends StatefulWidget {
  String tokenResgatante;

  SaldoCashbackCCDonoPage(this.tokenResgatante);

  @override
  _SaldoCashbackCCDonoPageState createState() => _SaldoCashbackCCDonoPageState();
}

class _SaldoCashbackCCDonoPageState extends State<SaldoCashbackCCDonoPage> {

  String _token;
  String _tokenidr;
  String _urlControlador;
  

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _tokenidr = widget.tokenResgatante;
    _urlControlador = GlobalStartup().getGateway() + "/";

  }

  Future<Map> _getSaldoCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appGetSaldoCashbackCCPeloDono.php?tokenid=$_token&tokenidr=$_tokenidr';
    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _getSaldoCashbackCC(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new CommonLoading();
          case ConnectionState.done:
            print("fiz...");
            if(snapshot.hasError) {
            }
            if(snapshot.hasData){
              return SaldoCashbackCCDonoLV(snapshot.data);
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
