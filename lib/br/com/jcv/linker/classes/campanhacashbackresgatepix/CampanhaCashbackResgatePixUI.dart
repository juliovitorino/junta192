import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class CampanhaCashbackResgatePixUI extends StatefulWidget {

  dynamic _campanhacashbackresgatepixVO;

  CampanhaCashbackResgatePixUI(this._campanhacashbackresgatepixVO);

  @override
  _CampanhaCashbackResgatePixUIState createState() => _CampanhaCashbackResgatePixUIState();
}

class _CampanhaCashbackResgatePixUIState extends State<CampanhaCashbackResgatePixUI> {

  String _token;
  String _urlControlador;
   bool _isVisibleActionBtn = false;

  @override
  initState() {
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
  }

  @override
  Widget build(BuildContext context) {

    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}),
        CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Apagar", (){}),
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
                    new CommonImageCircle("no-user.png"
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Titulo principal" ,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        Text(widget._campanhacashbackresgatepixVO['statusdesc'].toUpperCase(),
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                        Text(widget._campanhacashbackresgatepixVO['id'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['idCampanhaCashback'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['idUsuarioSolicitante'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['tipoChavePix'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['chavePix'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['valorResgate'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['autenticacaoBco'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['estagioRealTime'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['dtEstagioAnalise'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['dtEstagioFinanceiro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['dtEstagioErro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['dtEstagioTranfBco'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['txtLivreEstagioRT'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['status'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['dataCadastro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                        Text(widget._campanhacashbackresgatepixVO['dataAtualizacao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                      ],
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


