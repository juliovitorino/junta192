import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoAvaliacao.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoDetail.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/followup/followup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';


class CartaoPageResgate extends StatefulWidget {
  dynamic cartaofull;

  CartaoPageResgate(this.cartaofull);

  @override
  _CartaoPageResgateState createState() => _CartaoPageResgateState();
}

class _CartaoPageResgateState extends State<CartaoPageResgate> {

  Widget _fup1;
  Widget _fup2;
  Widget _fup3;
  Widget _fup;
  String _token;
  String _hash;
  String _urlControlador;
  int _cartaoid;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _cartaoid = widget.cartaofull['cartao']['id'];
    _hash = widget.cartaofull['cartao']['hashresgate'];
  }

  Future<Map> _confirmaRecebimento() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appRealizarConfirmacaoRecebimentoRecompensa.php?tokenid=${_token}&hash=${_hash}';

    response = await http.get(Uri.parse('$url'));
    return json.decode(response.body);
  }

  void _confirmarRecebimentoClick() {
    _confirmaRecebimento().then((mapa) {
      CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
          context: context,
          icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
          msg: mapa['msgcodeString']
      );
      escolha.showDialogYesNo().then((mapa){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new CartaoAvaliacao(widget.cartaofull) ),
        );

      });
      switch (mapa['msgcode']) {
        case "MSG-0068":
          break;
        default:
      }
    });
  }


  Future<Map> _getCartaoDigital() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appPesquisarCartaoFull.php?tokenid=$_token&cartaoid=$_cartaoid';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Stream<Map> _stream() async*{
    Duration interval = Duration(seconds: 1);
    int i=0;
    while (i++<1260){
      print(i.toString());
      await Future.delayed(interval);
      Stream<Map> stream = Stream<Map>.fromFuture(_getCartaoDigital());
      yield* stream;
    }
  }

  Widget _buildFollowUp(Map mapa) {
    int _cartao_status;
    dynamic _cartao = mapa['cartao'];
    switch(_cartao['status']){
      case '0':
      case '1':
      case '2':
      case '3':
        _cartao_status = int.parse(_cartao['status']) + 1;
        break;
      default:
        _cartao_status = -1;

    }
    _fup1 = Followup("1", "Completo", 0, _cartao_status );
    _fup2 = Followup("2", "Validar", 1, _cartao_status );
    _fup3 = Followup("3", "Entregar", 2, _cartao_status );

    _fup = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _fup1,
        Container(height: 1, width: 40, color: Colors.grey[500],),
        _fup2,
        Container(height: 1, width: 40, color: Colors.grey[500],),
        _fup3,
      ],
    );

    return _fup;
  }

  @override
  Widget build(BuildContext context) {

    _fup1 = Followup("1", "Completo", 0, -1);
    _fup2 = Followup("2", "Validar", 1, -1);
    _fup3= Followup("3", "Entregar", 2, -1);

    _fup = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _fup1,
        Container(height: 1, width: 40, color: Colors.grey[500],),
        _fup2,
        Container(height: 1, width: 40, color: Colors.grey[500],),
        _fup3,
      ],
    );

    return Scaffold(
      appBar: new AppBar(
        title: Text("Resgatar Recompensa", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Apresente o Código",
              style: TextStyle(fontSize: 26.0),
            ),
            Text("ao Patrocinador",
              style: TextStyle(fontSize: 26.0),
            ),
            Icon(Icons.arrow_drop_down_circle, size: 50.0),
            QrImage(
              data: widget.cartaofull['cartao']['hashresgate'],
              size: 300,
              gapless: true,
              errorCorrectionLevel: QrErrorCorrectLevel.Q,
            ),
            SizedBox(height: 20,),
            //_fup,

            StreamBuilder(
              stream: _stream(), // a Stream<Map> or null
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    print('ConnectionState.none');
                    return _fup;
                  case ConnectionState.waiting:
                    print('ConnectionState.waiting');
                    return _fup;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    print('ConnectionState.active');
                    if(snapshot.hasData){
                      if(snapshot.data['cartao']['status'] == '2'){
//                        Navigator.of(context).pop();
                        _confirmaRecebimento().then((mapa) {
                          CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
                              context: context,
                              icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
                              msg: mapa['msgcodeString']
                          );
                          escolha.showDialogYesNo().then((mapa){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new CartaoAvaliacao(widget.cartaofull) ),
                            );

                          });
                          switch (mapa['msgcode']) {
                            case "MSG-0068":
                              break;
                            default:
                          }
                        });

                        return Container(height: 0, width: 0,);
                      }
                      return _buildFollowUp(snapshot.data);
                    }
                    return _fup;
                  default:
                    return _fup;
                }
              },
            ),


            SizedBox(height: 20,),
            new CartaoDetail(widget.cartaofull),
          ],
        ),
      ),
    );

  }
}


