import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

class CartaoPageEntregaResgate extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  CartaoPageEntregaResgate({
    Key key, 
    @required this.session
  }) : super(key: key);

  @override
  _CartaoPageEntregaResgateState createState() => _CartaoPageEntregaResgateState();
}

class _CartaoPageEntregaResgateState extends State<CartaoPageEntregaResgate> {

  final _hashController = new TextEditingController();
  final _statusLoading = new CommonLoading();
  var _statusCarimbo = new CommonMsgCode(msgcode: "MSG-0001", msgcodeString: "Clique no QR Code");
  bool _checking = false;
  bool _acaobtn = true;
  RaisedButton _btnValidarEntrega;
  RaisedButton _btnPatrocinadorEntrega;

  String _token;
  String _urlControlador;
  String _hash = "00000000";

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }  

  void _carimboClick(){
    setState(() {
        _checking = true;
    });
    _hash = _hashController.text; 
    _carimbarCartelaDigital().then((mapa) {
      Icon _icon = mapa['msgcode'] == "MSG-0061"
      ? new Icon(Icons.check_circle_outline, size: 100.0, color: Colors.greenAccent)
      : new Icon(Icons.block, size: 120.0, color: Colors.redAccent);
      CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
              context: context,
              icon: _icon ,
              msg: mapa['msgcodeString']
      );
      escolha.showDialogYesNo().then((onValue){
        if(mapa['msgcode'] == "MSG-0061"){
          setState(() {
              _acaobtn = false;
          });
        } else if(mapa['msgcode'] == "MSG-0064"){
            CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
                    context: context,
                    icon: Icon(Icons.check_circle_outline, size: 100.0, color: Colors.greenAccent) ,
                    msg: "Você deseja ENTREGAR a recompensa ao cliente?",
                    textYes: "Sim",
                    textNo: "Não",
            );
            escolha.showDialogYesNo().then((onValue){
              if(escolha.getChoice() == 'Y'){
                setState(() {
                    _acaobtn = false;
                });
              } else {
                setState(() {
                    _acaobtn = true;
                });
              }
            });
        }
      });

      setState(() {
          _statusCarimbo = CommonMsgCode(msgcode: mapa['msgcode'], msgcodeString: mapa['msgcodeString']);
          _checking = false;
      });
    });
  }

  void _entregaClick(){
      CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
              context: context,
              icon: Icon(Icons.check_circle_outline, size: 100.0, color: Colors.greenAccent) ,
              msg: "Você confirma a ENTREGA da recompensa ao cliente?",
              textYes: "Sim",
              textNo: "Não",
      );
      escolha.showDialogYesNo().then((onValue){

        if(escolha.getChoice() == 'Y'){
          setState(() {
              _checking = true;
          });
          _hash = _hashController.text; 
          _carimbarEntregaRecompensaPatrocinador().then((mapa) {
            Icon _icon = mapa['msgcode'] == "MSG-0066"
            ? new Icon(Icons.check_circle_outline, size: 100.0, color: Colors.greenAccent)
            : new Icon(Icons.block, size: 120.0, color: Colors.redAccent);
            CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
                    context: context,
                    icon: _icon ,
                    msg: mapa['msgcodeString']
            );
            escolha.showDialogYesNo();
            setState(() {
                _statusCarimbo = CommonMsgCode(msgcode: mapa['msgcode'], msgcodeString: mapa['msgcodeString']);
                _checking = false;
                _acaobtn = true;
            });
          });
        }
        
      });


  }


  Future<Map> _carimbarCartelaDigital() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appRealizarResgateCartao.php?tokenid=$_token&hash=$_hash';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future<Map> _carimbarEntregaRecompensaPatrocinador() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appRealizarEntregaRecompensa.php?tokenid=$_token&hash=$_hash';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future _qrScan() async{
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        _hashController.text = qrResult.rawContent;        
      });
      _carimboClick();
    } on PlatformException catch (e) {
      if(e.code == BarcodeScanner.cameraAccessDenied){
        setState(() {
          _hashController.text = "Permissão de câmera negada";
        });
      } else {
        setState(() {
          _hashController.text = "Erro desconhecido";
        });

      }
    } on FormatException {
        setState(() {
          _hashController.text = "Voce Pressionou back Button antes de scanner";
        });

    } catch (e){
        setState(() {
          _hashController.text = "Erro desconhecido $e";
        });

    }

  }



  @override
  Widget build(BuildContext context) {
    _btnValidarEntrega = RaisedButton(
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: _carimboClick ,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(" Validar Cartão ", 
                                          style: TextStyle(color: Colors.white, fontSize: 25.0)),
                                ),
                                color: Colors.green
                              );
    _btnPatrocinadorEntrega = RaisedButton(
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: _entregaClick ,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(" Entregar Recompensa ", 
                                          style: TextStyle(color: Colors.white, fontSize: 25.0)),
                                ),
                                color: Colors.green
                              );


    return Scaffold(
        appBar: new AppBar(
          title: Text("Entregar Recompensa"),
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Clique no botão abaixo",
                      style: TextStyle(fontSize: 26.0),
                    ),
                    Icon(Icons.arrow_drop_down_circle, size: 50.0),
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
                          controller: _hashController,
                          decoration: InputDecoration(
                                labelText: "Digite o código se preferir",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder()
                            ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        height: 50.0,
                        child: _acaobtn ? _btnValidarEntrega : _btnPatrocinadorEntrega
                      ),
                      Container(
                        child: !_checking ? _statusCarimbo : _statusLoading,
                      )

                    ],

                  ),
                ),
                

              ],
            ),
      ),
    );
  }
}