import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'CartaoMoverHistoricoLV.dart';
import 'CartaoMoverHistoricoPageCRUD.dart';

class CartaoMoverHistoricoPage extends StatefulWidget {
  final dynamic cartaofull;

  CartaoMoverHistoricoPage(this.cartaofull);

  @override
  _CartaoMoverHistoricoPageState createState() => _CartaoMoverHistoricoPageState();
}

class _CartaoMoverHistoricoPageState extends State<CartaoMoverHistoricoPage> {

  String _token;
  String _urlControlador;
  String _cartid;

  int _pag = 1;

  @override
  _CartaoMoverHistoricoPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _cartid = widget.cartaofull['cartao']['id'].toString();

  }

  Future<Map> _listCartaoMoverHistorico() async {
    http.Response response;
    String _url = '${_urlControlador}appListarCartaoMoverHistoricoPorCartIdStatus.php?tokenid=$_token&cartid=$_cartid&pag=$_pag';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Movimentação do Cartão"),
      ),
      body: FutureBuilder(
        future: _listCartaoMoverHistorico(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new CommonLoading();
            case ConnectionState.done:
              if(snapshot.hasError) {
                return new Container(
                  height: 0.0,
                  width: 0.0,
                );
              }
              if(snapshot.hasData){
                return CartaoMoverHistoricoLV(snapshot.data);
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
