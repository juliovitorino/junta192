import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';

class CampanhaCashbackUI extends StatefulWidget {

  dynamic _campanhacashbackVO;

  CampanhaCashbackUI(this._campanhacashbackVO);

  @override
  _CampanhaCashbackUIState createState() => _CampanhaCashbackUIState();
}

class _CampanhaCashbackUIState extends State<CampanhaCashbackUI> {

  String _token;
  String _urlControlador;
  bool _isVisibleActionBtn = false;

  @override
  void initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  @override
  Widget build(BuildContext context) {
    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Cancelar", (){}),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Configuração do cashback da campanha" ,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        Text(widget._campanhacashbackVO['statusdesc'].toUpperCase(),
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                        Text(widget._campanhacashbackVO['percentualFmt'] + "%",
                            style: TextStyle(fontSize: 32)),                            
                        Text('Encerra em ' + widget._campanhacashbackVO['dataTermino']),
                      ],
                    ),
                    IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                      setState(() {
                         _isVisibleActionBtn = !_isVisibleActionBtn;

                      });
                    },)
                  ],
                ),
                Text(widget._campanhacashbackVO['obs']),
                SizedBox(height: 10,),
                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,)
              ],

            ),
          ),
        )
    );
  }
}

/*
                Text(widget._campanhacashbackVO['id'].toString()),
                Text(widget._campanhacashbackVO['id_usca'].toString()),
                Text(widget._campanhacashbackVO['id_campanha'].toString()),
                Text(widget._campanhacashbackVO['id_usuario'].toString()),
                Text(widget._campanhacashbackVO['percentualFmt']),
                Text(widget._campanhacashbackVO['dataTermino']),
                Text(widget._campanhacashbackVO['obs']),
                Text(widget._campanhacashbackVO['status']),
                Text(widget._campanhacashbackVO['dataCadastro']),
                Text(widget._campanhacashbackVO['dataAtualizacao']),

*/