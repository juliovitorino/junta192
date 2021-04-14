import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:junta192/br/com/jcv/linker/classes/cashback/SaldoCashbackCCDonoPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

class UsuarioCashbackQRCodeIDCliente extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
/*  
  final SessionStorage session;

  UsuarioCashbackQRCodeIDCliente({
    Key key, 
    @required this.session
  }) : super(key: key);
*/
  @override
  _UsuarioCashbackQRCodeIDClienteState createState() => _UsuarioCashbackQRCodeIDClienteState();
}

class _UsuarioCashbackQRCodeIDClienteState extends State<UsuarioCashbackQRCodeIDCliente> {

  final _hashController = new TextEditingController();
  var _statusCarimbo = new CommonMsgCode(msgcode: "MSG-0001", msgcodeString: "Clique no QR Code");
  RaisedButton _btnValidarEntrega;
  
  String _token;
  String _hash = "00000000";
  bool _isbodymain = true;
  Widget _bodySaldoCC;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
  }  

  void _carimboClick(){
    setState(() {
      _hash = _hashController.text; 
      _isbodymain = false;
      _bodySaldoCC = new SaldoCashbackCCDonoPage(_hash);
      
    });


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

    Widget _bodyMain = SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10,),
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

                    ],

                  ),
                ),
              ],
            ),
      );


    return Scaffold(
        appBar: new AppBar(
          title: Text("Dar Crédito ao Cliente"),
        ),
        body: _isbodymain ? _bodyMain : _bodySaldoCC,
    );
  }
}