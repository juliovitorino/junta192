import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackcc/CampanhaCashbackCCPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackresgatepix/CampanhaCashbackResgatePixPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-pageroute.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/util/play_helper.dart';

class SaldoCashbackCCUI extends StatefulWidget {

  dynamic _saldoCashbackCCVO;

  SaldoCashbackCCUI(this._saldoCashbackCCVO);

  @override
  _SaldoCashbackCCUIState createState() => _SaldoCashbackCCUIState();
}

class _SaldoCashbackCCUIState extends State<SaldoCashbackCCUI> {

  String _token;
  String _urlControlador;
  String _tipousuario;
  String _desc;
  ScanResult _usuaid;
  String _donoid;
  String _vlr;
  bool _istransf = false;
  bool _isliquidar = false;
  bool _ismembro = false;
  bool _isUsuarioComun = true;
  bool _isActionBtn = false;


  TextEditingController tecTransf = new TextEditingController();
  TextEditingController tecDesc = new TextEditingController();

  Future<ScanResult> _qrScan() async{
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      return qrResult;
    } on PlatformException catch (e) {
      if(e.code == BarcodeScanner.cameraAccessDenied){
        setState(() {
          Navigator.pop(context, "Permissão de câmera negada");
        });
      } else {
        setState(() {
          Navigator.pop(context, "Erro desconhecido");
        });

      }
    } on FormatException {
        setState(() {
          Navigator.pop(context, "no-scan");
        });

    } catch (e){
        setState(() {
          Navigator.pop(context, "Erro desconhecido $e");
        });

    }

  }

  Future<Map> _transferirEntreMembrosCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appTransferirEntreMembroCashbackCC.php?tokenid=$_token&usuaid=${_usuaid.rawContent}&donoid=$_donoid&vlr=$_vlr&desc=$_desc';

   debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }


  Future<Map> _depositarCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appTransferirCashbackCC.php?tokenid=$_token&usuaid=${_usuaid.rawContent}&vlr=$_vlr&desc=$_desc';

   debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  Future<Map> _liquidarCashbackCC() async {
    http.Response response;
    String _url = '${_urlControlador}appLiquidarCashbackCC.php?tokenid=$_token&usuaid=${_usuaid.rawContent}&vlr=$_vlr&desc=$_desc';

   debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  void executarLiquidarClick(String vlrstr, String vlrpost) {

    CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.question_answer, size: 128,),
      msg: "Tem certeza de liquidar o recebido do valor $vlrstr do seu cashback?",
      textYes: "Sim, eu quero",
      textNo: "Não, em outro momento",
    );
    csdyn.showDialogYesNo().then((onValue) {
      if (csdyn.getChoice() == 'Y'){
        _usuaid = widget._saldoCashbackCCVO['dono']['id'];
        _vlr = vlrpost;
        _desc = tecDesc.text;

        _liquidarCashbackCC().then((mapa){
          if( mapa['msgcode'] == 'MSG-0108'){
            CommonShowDialogYesNo c = new CommonShowDialogYesNo(
              context: context, 
              icon: Icon(Icons.cancel, size: 128, color: Colors.red,),
              msg: mapa['msgcodeString']
            );
            c.showDialogYesNo();
          } else {
            CommonShowDialogYesNo c = new CommonShowDialogYesNo(
              context: context, 
              icon: Icon(Icons.question_answer, size: 128,),
              msg: mapa['msgcodeString']
            );
            c.showDialogYesNo().then((onValue){
              if (c.getChoice() == 'Y') {
                PlayHelper.play(sndCashRegister);
                SnackBar snck = new SnackBar(content: Text(mapa['msgcodeString'] + ". Seu saldo será atualizado na próxima carga."));
                Scaffold.of(context).showSnackBar(snck);
                //Navigator.of(context).pop();
              }
            });

          }

        });
      }

    });
  }


  void executarTransferenciaClick(String vlrstr, String vlrpost) {

    CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.question_answer, size: 128,),
      msg: "Tem certeza de realizar a transferência do valor $vlrstr do seu cashback?",
      textYes: "Sim, eu quero",
      textNo: "Não, em outro momento",
    );
    csdyn.showDialogYesNo().then((onValue) {
      if (csdyn.getChoice() == 'Y'){
        _usuaid = widget._saldoCashbackCCVO['dono']['id'];
        _vlr = vlrpost;
        _desc = tecDesc.text;

        _depositarCashbackCC().then((mapa){
          if( mapa['msgcode'] == 'MSG-0108'){
            CommonShowDialogYesNo c = new CommonShowDialogYesNo(
              context: context, 
              icon: Icon(Icons.cancel, size: 128, color: Colors.red,),
              msg: mapa['msgcodeString']
            );
            c.showDialogYesNo();
          } else {
            CommonShowDialogYesNo c = new CommonShowDialogYesNo(
              context: context, 
              icon: Icon(Icons.question_answer, size: 128,),
              msg: mapa['msgcodeString']
            );
            c.showDialogYesNo().then((onValue){
              if (c.getChoice() == 'Y') {
                PlayHelper.play(sndCashRegister);
                SnackBar snck = new SnackBar(content: Text(mapa['msgcodeString'] + ". Seu saldo será atualizado na próxima carga."));
                Scaffold.of(context).showSnackBar(snck);
                //Navigator.of(context).pop();
              }
            });

          }

        });
      }

    });
  }


  void executarTransfMembroClick(String vlrstr, String vlrpost) async {
    CommonShowDialogYesNo csdyn1 = new CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.question_answer, size: 128,),
      msg: "Tire uma foto QR Code do membro do Junta10",
    );
    await csdyn1.showDialogYesNo();

    _usuaid = await _qrScan();
    if(_usuaid.rawContent == "no-scan"){
      return;
    }

    CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.question_answer, size: 128,),
      msg: "Tem certeza de realizar a transferência do valor $vlrstr do seu cashback?",
      textYes: "Sim, eu quero",
      textNo: "Não, em outro momento",
    );
    csdyn.showDialogYesNo().then((onValue) {
      if (csdyn.getChoice() == 'Y'){
        _donoid = widget._saldoCashbackCCVO['dono']['id'];
        _vlr = vlrpost;
        _desc = tecDesc.text;

        _transferirEntreMembrosCashbackCC().then((mapa) {
          if( mapa['msgcode'] == 'MSG-0108'){
            CommonShowDialogYesNo c = new CommonShowDialogYesNo(
              context: context, 
              icon: Icon(Icons.cancel, size: 128, color: Colors.red,),
              msg: mapa['msgcodeString']
            );
            c.showDialogYesNo();
          } else {
            CommonShowDialogYesNo c = new CommonShowDialogYesNo(
              context: context, 
              icon: Icon(Icons.question_answer, size: 128,),
              msg: mapa['msgcodeString']
            );
            c.showDialogYesNo().then((onValue){
              if (c.getChoice() == 'Y') {
                PlayHelper.play(sndCashRegister);
                SnackBar snck = new SnackBar(content: Text(mapa['msgcodeString'] + ". Seu saldo será atualizado na próxima carga."));
                Scaffold.of(context).showSnackBar(snck);
                //Navigator.of(context).pop();
              }
            });

          }

        });
      }

    });



  }


  @override
  void initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _tipousuario = CacheSession().getSession()['tipousuario'];
    _isUsuarioComun = _tipousuario == "C";
    tecDesc.text = "Transferência de valores";
  }

  Widget _createCampoMovimentacaoCC(String titulo, Function function) => Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          TextField(
              textAlign: TextAlign.right,
              controller: tecTransf,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                    labelText: "R\$",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.0
            ),
          ),
          SizedBox(height: 10,),
          // Descrição para historico
          TextField(
              controller: tecDesc,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Digite uma descrição",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0
            ),
          ),

          // Botão para acionar a devolução parcial
          CommomActionButton(titulo: titulo , onpressed: function, color:Colors.blue),

        ],
      )
    );



  @override
  Widget build(BuildContext context) {

    Widget widtransf = _createCampoMovimentacaoCC("Confirmar Transferência", (){
              executarTransferenciaClick(tecTransf.text, tecTransf.text);
          });
    Widget widliquidar = _createCampoMovimentacaoCC("Confirmar Liquidação", (){
              executarLiquidarClick(tecTransf.text, tecTransf.text);
          });
    Widget widtransMembro = _createCampoMovimentacaoCC("Confirmar Transferência", (){
              executarTransfMembroClick(tecTransf.text, tecTransf.text);
    });

    Widget widActionBtn = Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CommonFlatButtonPageRoute(Icon(Icons.closed_caption, color: Colors.white,), "Ver meu Extrato", new CampanhaCashbackCCPage(int.parse(widget._saldoCashbackCCVO['id_dono']))),
              CommonFlatButtonFunction(Icon(Icons.cached, color: Colors.white), "Transferência", (){
                setState(() {
                  _istransf = !_istransf;
                });

              }),
            ],
          ),
          !_isUsuarioComun ?
          CommonFlatButtonFunction(Icon(Icons.file_download, color: Colors.white), "Liquidar Recebido", (){
                setState(() {
                  _isliquidar = !_isliquidar;
                  tecTransf.text = widget._saldoCashbackCCVO['vlsld'].toString();
                });
          }) : Container(height: 0, width: 0,),
          _isUsuarioComun ? 
          CommonFlatButtonFunction(Icon(Icons.group, color: Colors.white), "Transferência entre membros Junta10", () {
                setState(() {
                  _ismembro = !_ismembro;
                }); 
          }): Container(height: 0, width: 0,),
          widget._saldoCashbackCCVO['usca']['permitirResgateViaPix'] == "S" && widget._saldoCashbackCCVO['vlsld'] > widget._saldoCashbackCCVO['usca']['vlMinimoResgate']
          ? CommonFlatButtonPageRoute(Icon(Icons.money, color: Colors.white,)
            , "Resgatar via PIX a partir " + widget._saldoCashbackCCVO['usca']['vlMinimoResgateMoeda']
            , new CampanhaCashbackResgatePixPage(widget._saldoCashbackCCVO)
          )
          : CommonFlatButtonFunction(Icon(Icons.money, color: Colors.white)
            , "Resgatar via PIX a partir " + widget._saldoCashbackCCVO['usca']['vlMinimoResgateMoeda']
            , (){}
            , color: Colors.grey ),
          _istransf ? widtransf : Container(height: 0, width: 0,),
          _isliquidar && !_isUsuarioComun ? widliquidar : Container(height: 0, width: 0,),
          _ismembro && _isUsuarioComun ? widtransMembro : Container(height: 0, width: 0,)

        ],
      ),
    );

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:8.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new CommonImageCircle(widget._saldoCashbackCCVO['dono']['urlfoto']
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget._saldoCashbackCCVO['dono']['apelido'] ,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget._saldoCashbackCCVO['vlsldMoeda'].toString() ,
                                style: TextStyle(fontSize: 26, color: Colors.black)),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){
                                setState(() {
                                  _isActionBtn = !_isActionBtn; 
                                });
                              } ),
                            ),

                          ],
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                _isActionBtn ? widActionBtn : Container(height: 0, width: 0,),

              ],
            ),
          ),
        )
    );
  }
}
