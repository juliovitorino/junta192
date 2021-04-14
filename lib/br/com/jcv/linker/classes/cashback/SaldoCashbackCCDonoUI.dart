import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackcc/CampanhaCashbackCCDonoPage.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-pageroute.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/util/play_helper.dart';

class SaldoCashbackCCDonoUI extends StatefulWidget {

  dynamic _saldoCashbackCCVO;
  int id_usuario;

  SaldoCashbackCCDonoUI(this.id_usuario, this._saldoCashbackCCVO);

  @override
  _SaldoCashbackCCDonoUIState createState() => _SaldoCashbackCCDonoUIState();
}

class _SaldoCashbackCCDonoUIState extends State<SaldoCashbackCCDonoUI> {

  String _token;
  String _urlControlador;
  String _usuaid;
  String _vlr;
  String _desc;
  bool _isValPresente = false;
  TextEditingController tecDevolucao = new TextEditingController();
  TextEditingController tecDesc = new TextEditingController();

  Future<Map> _depositarCashbackCC() async {
    http.Response response;
//    String _url = '${_urlControlador}appResgateTotalCashbackCC.php?tokenid=${_token}&usuaid=${_usuaid}&vlr=${_vlr}';
//    String _url = '${_urlControlador}appResgateCashbackCC.php?tokenid=${_token}&usuaid=${_usuaid}&vlr=${_vlr}';
    String _url = '${_urlControlador}appCreditarCashbackCC.php?tokenid=${_token}&usuaid=${_usuaid}&vlr=${_vlr}&desc=${_desc}';

   debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }
  
  @override
  void initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    tecDesc.text = "Vale presente ";
  }

  void executarDepositoClick(String vlrstr, String vlrpost) {

    CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.question_answer, size: 128,),
      msg: "Tem certeza de realizar a depositar o valor $vlrstr em cashback?",
      textYes: "Sim, eu quero",
      textNo: "Não, em outro momento",
    );
    csdyn.showDialogYesNo().then((onValue) {
      if (csdyn.getChoice() == 'Y'){
        _usuaid = widget.id_usuario.toString();
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
                Navigator.of(context).pop();
              }
            });

          }

        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    Widget widValePresente = Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          TextField(
              textAlign: TextAlign.right,
              controller: tecDevolucao,
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
          CommomActionButton(titulo: "Confirmar Depósito" , onpressed: (){
              executarDepositoClick(tecDevolucao.text, tecDevolucao.text);

          }, color:Colors.blue) 

        ],
      )

      
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
                        Text(widget._saldoCashbackCCVO['vlsldMoeda'] ,
                            style: TextStyle(fontSize: 26, color: Colors.black)),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CommonFlatButtonPageRoute(Icon(Icons.closed_caption, color: Colors.white,), "Ver Extrato", new CampanhaCashbackCCDonoPage(widget.id_usuario)),
                    CommonFlatButtonFunction(Icon(Icons.monetization_on, color: Colors.white), "Vale-Presente", (){
                      setState(() {
                        _isValPresente = !_isValPresente;
                      });
                    }),
/*
                    CommonOutlineButtonFunction(Icon(Icons.monetization_on)
                      , "Devolver total", () async {
                        executarDepositoClick(widget._saldoCashbackCCVO['vlsldMoeda'], widget._saldoCashbackCCVO['vlsld']);
                      }
                    ),
*/                    
                  ],
                ),
                _isValPresente ? widValePresente : Container(height: 0, width: 0,)

              ],
            ),
          ),
        )
    );
  }
}
