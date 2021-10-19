import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class PlanoUI extends StatefulWidget {

  dynamic _planoVO;

  PlanoUI(this._planoVO);

  @override
  _PlanoUIState createState() => _PlanoUIState();
}

class _PlanoUIState extends State<PlanoUI> {

  String _token;
  String _urlControlador;
   bool _isVisibleActionBtn = true;
   String _id;

  @override
  initState() {
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _id = widget._planoVO['id'];

  }

  Future<Map> _apagarPlano() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appApagarPlano.php?tokenid=$_token&id=$_id';
print(url);
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }



  void _apagarPlanoClick() {

    CommonShowDialogYesNo apagarClick = CommonShowDialogYesNo(
      context: context, 
      icon: Icon(Icons.help, size: 120.0, color: Colors.blue), 
      textYes: "Sim",
      textNo: "Não",
      msg: "Deseja REALMENTE APAGAR ?");

    apagarClick.showDialogYesNo().then((value) {
      if (apagarClick.getChoice() == "Y") {
        _apagarPlano().then((mapa) {
          CommonShowDialogYesNo msgretorno = CommonShowDialogYesNo (
            context: context,
            icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
            msg: mapa['msgcodeString']
          )..showDialogYesNo();
        });
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Contratar", (){}),
        /*
        CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Apagar", (){
          _apagarPlanoClick();
        }, color: Colors.red[800]),
        */
      ],
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
                      /*
                    new CommonImageCircle("no-user.png"
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                        */
                    SizedBox(width: 8,),
                    Expanded(child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonDataItemTitleText("Plano", widget._planoVO['nome']),
                          Text(widget._planoVO['valorMoeda'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._planoVO['statusdesc'].toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.red)),
                          //Text(widget._planoVO['id'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._planoVO['permissao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._planoVO['tipo'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._planoVO['status'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._planoVO['dataCadastro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._planoVO['dataAtualizacao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ),

                    IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                      setState(() {
                         _isVisibleActionBtn = !_isVisibleActionBtn;

                      });
                    },)
                  ],
                ),
                SizedBox(height: 10,),
                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,)
              ],
            ),
          ),
        )
    );
  }
}

