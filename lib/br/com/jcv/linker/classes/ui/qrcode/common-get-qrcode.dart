import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class CommonGetQRCode extends StatefulWidget {

  @override
  _CommonGetQRCodeState createState() => _CommonGetQRCodeState();
}

class _CommonGetQRCodeState extends State<CommonGetQRCode> {

  final _hashController = new TextEditingController();
  
  String _hash = "00000000";

  Future _qrScan(BuildContext context) async{
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        _hashController.text = qrResult.rawContent;        
        _hash = _hashController.text; 
      });
      Navigator.pop(context, _hash);
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
                          onTap: () { _qrScan(context);},
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
                            onPressed: () {_qrScan(context);} ,
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
          title: Text("Capturar QR Code"),
        ),
        body: _bodyMain,
    );
  }
}