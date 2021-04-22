import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:junta192/br/com/jcv/linker/classes/admob/admob-custom.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoPageDetail.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoPageResgate.dart';
import 'package:junta192/br/com/jcv/linker/classes/comofunciona/como-funciona.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/util/play_helper.dart';

class ValidarTicketPage extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  ValidarTicketPage({
    Key key, 
    @required this.session
  }) : super(key: key);

  @override
  _ValidarTicketPageState createState() => _ValidarTicketPageState();
}

class _ValidarTicketPageState extends State<ValidarTicketPage> {

  final _ticketController = new TextEditingController();
  final _statusLoading = new CommonLoading();

  var _statusCarimbo = new CommonMsgCode(msgcode: "MSG-0001", msgcodeString: "Clique no QR Code");
  bool _checking = false;

  String _token;
  String _urlControlador;
  String _ticket = "00000000";
  String _status = "A";
  AdMobCustomFactory<BannerAd> _bannerAd = AdMobCustomFactory('BannerAd');
  
  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";

    MobileAds.instance.initialize().then((status) {
        print("inicialização do AdMob feita: ${status.adapterStatuses}");
      }
    );
  }  
  void _carimboClick(){
    setState(() {
        _checking = true;
    });
    _ticket = _ticketController.text; 
    _carimbarCartelaDigital().then((mapa) {

      Icon _icon;
      CommonShowDialogYesNo escolha;
      switch (mapa['msgcode']) {
        case 'MSG-0001':
        case 'MSG-0070':
          PlayHelper.play(sndCashRegister);
          _icon = new Icon(Icons.card_giftcard, size: 100.0, color: Colors.greenAccent);
          escolha = CommonShowDialogYesNo(
                  context: context,
                  icon: _icon ,
                  msg: mapa['msgcodeString'],
                  textYes: "OK, quero resgatar agora",
                  textNo: "Não, vou resgartar outro dia",
          );
          escolha.showDialogYesNo().then((onValue){
            if(escolha.getChoice() == 'Y'){
              _status = "0";
              _realizarPesquisaPeloCarimbo().then((mapa){
                if(mapa['msgcode'] == 'MSG-0001'){
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new CartaoPageResgate(mapa) ),
                        );
                }
              });
            }
          });    
          break;
        case 'MSG-0071':
          PlayHelper.play(sndCashRegister);
          _icon = new Icon(Icons.check_circle_outline, size: 100.0, color: Colors.greenAccent);
          escolha = CommonShowDialogYesNo(
                  context: context,
                  icon: _icon ,
                  msg: mapa['msgcodeString'],
                  textYes: "OK, quero ver meu cartão",
                  textNo: "Agora não",
          );
          escolha.showDialogYesNo().then((onValue){
            if(escolha.getChoice() == 'Y'){
              _status = "A";
              _realizarPesquisaPeloCarimbo().then((mapa){
                if(mapa['msgcode'] == 'MSG-0001'){
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new CartaoPageDetail(mapa) ),
                        );
                }

              });

            }
          });        
          break;
        case 'MSG-0072':
          PlayHelper.play(sndCashRegister);
          _icon = new Icon(Icons.tag_faces, size: 100.0, color: Colors.greenAccent);
          escolha = CommonShowDialogYesNo(
                  context: context,
                  icon: _icon ,
                  msg: mapa['msgcodeString'],
                  textYes: "OK, quero ver meu cartão",
                  textNo: "Agora não, mais tarde",
          );
          escolha.showDialogYesNo().then((onValue){
            if(escolha.getChoice() == 'Y'){
              _status = "A";
              _realizarPesquisaPeloCarimbo().then((mapa){
                if(mapa['msgcode'] == 'MSG-0001'){
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new CartaoPageDetail(mapa) ),
                        );
                }
              });
            }
          });        
          break;
        default:
          _icon = new Icon(Icons.block, size: 120.0, color: Colors.redAccent);
          escolha = CommonShowDialogYesNo(
                  context: context,
                  icon: _icon ,
                  msg: mapa['msgcodeString']
          );
          escolha.showDialogYesNo();
      }


      setState(() {
        _statusCarimbo = CommonMsgCode(msgcode: mapa['msgcode'], msgcodeString: mapa['msgcodeString']);
        _checking = false;
      });
    });
  }

  void _comoFuncionaClick(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new ComoFuncionaPage() ),
          );
  }

  Future<Map> _carimbarCartelaDigital() async {
    http.Response response;
    if (_ticket.length > 8){
      // Solicita a requisição na URL por enquanto sem callback
      String url='${_urlControlador}validarQrcodeController.php?qrc=$_ticket&token=$_token';
      //debugPrint(_urlControlador);
      response = await http.get(Uri.parse(url));
      return json.decode(response.body);
    } else {
      // Solicita a requisição na URL por enquanto sem callback
      response = await http.get(Uri.parse('${_urlControlador}validarTicketController.php?ticket=$_ticket&token=$_token'));
      //debugPrint(_urlControlador);
      return json.decode(response.body);
    }
  }

  Future<Map> _realizarPesquisaPeloCarimbo() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appPesquisarCartaoFullCarimbo.php?tokenid=${_token}&qrc=${_ticket}&status=${_status}';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future _qrScan() async{
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        _ticketController.text = qrResult.rawContent;        
      });
      _carimboClick();
    } on PlatformException catch (e) {
      if(e.code == BarcodeScanner.cameraAccessDenied){
        setState(() {
          _ticketController.text = "Permissão de câmera negada";
        });
      } else {
        setState(() {
          _ticketController.text = "Erro desconhecido";
        });

      }
    } on FormatException {
        setState(() {
          _ticketController.text = "Voce Pressionou back Button antes de scanner";
        });

    } catch (e){
        setState(() {
          _ticketController.text = "Erro desconhecido $e";
        });

    }

  }



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: FutureBuilder<BannerAd>(
                          future: _bannerAd.bannerLoad(),
                          builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
                            Widget child;

                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                              case ConnectionState.active:
                                child = Container();
                                break;
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  child = AdWidget(ad: snapshot.data);
                                } else {
                                  child = Text('Error loading $BannerAd');
                                }
                            }

                            return Container(
                              width: _bannerAd.getBanner().size.width.toDouble(),
                              height: _bannerAd.getBanner().size.height.toDouble(),
                              color: Colors.blueGrey,
                              child: child,
                            );
                          },
                        ),
                      ) ,


/*
                    Text("Clique no botão abaixo",
                      style: TextStyle(fontSize: 26.0),
                    ),
                    Icon(Icons.arrow_drop_down_circle, size: 50.0),
*/
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: _qrScan,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(80.0, 20.0, 80.0, 20.0),
                            child: Image.asset('assets/images/qrcode.png'),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 85,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: _qrScan ,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.camera_alt, size: 35.0, color: Colors.white,),
                                  Text(" Capturar ", 
                                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                                ],
                              )
                            ),
                            color: Colors.green
                          ),
                        )
                      ],
                    ),

                  ],
                ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                      keyboardType: TextInputType.text,
                      controller: _ticketController,
                      decoration: InputDecoration(
                            labelText: "Digite o ticket se preferir",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder()
                        ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    ),
                  ),
//------------------------------------------------------------------------------                  
// Botão Como Funciona?
//------------------------------------------------------------------------------                  
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    height: 50.0,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: _comoFuncionaClick ,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text("Clique aqui e veja como funciona", 
                                style: TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                      color: Colors.blue
                    )
                  ),

//------------------------------------------------------------------------------                  
// Botão carimbar cartela
//-----------------------------------------------------------------------------                  
/*
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    height: 50.0,
                    child: RaisedButton(
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: _carimboClick ,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Carimbar Cartela Digital", 
                                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                            ),
                            color: Colors.green
                          )
                  ),
*/                  
                  Container(
                    child: !_checking ? _statusCarimbo : _statusLoading,
                  )

                ],

              ),
            ),
            

          ],
        ),
    );
  }
}