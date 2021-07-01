import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/cashback/SaldoCashbackCCLV.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class SaldoCashbackCCPage extends StatefulWidget {

  @override
  _SaldoCashbackCCPageState createState() => _SaldoCashbackCCPageState();
}

class _SaldoCashbackCCPageState extends State<SaldoCashbackCCPage> {

  String _token;
  String _urlControlador;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";

  }

  Future<Map> _getSaldoCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appGetSaldoCashbackCC.php?tokenid=$_token';
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
            print("fiz");
            if(snapshot.hasError) {
            }
            if(snapshot.hasData){
              return SaldoCashbackCCLV(snapshot.data);
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
