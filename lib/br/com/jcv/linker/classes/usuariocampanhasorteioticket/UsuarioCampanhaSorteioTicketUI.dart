import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class UsuarioCampanhaSorteioTicketUI extends StatefulWidget {

  dynamic _usuariocampanhasorteioticketVO;

  UsuarioCampanhaSorteioTicketUI(this._usuariocampanhasorteioticketVO);

  @override
  _UsuarioCampanhaSorteioTicketUIState createState() => _UsuarioCampanhaSorteioTicketUIState();
}

class _UsuarioCampanhaSorteioTicketUIState extends State<UsuarioCampanhaSorteioTicketUI> {

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
/*    
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}),
        CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Apagar", (){}),
      ],
    );
*/
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(widget._usuariocampanhasorteioticketVO['ticket'] ,style: TextStyle(fontSize: 20, color: Colors.black)),

        //CommonDataItemTitleText("Bilhete", widget._usuariocampanhasorteioticketVO['ticket'], color: Colors.blue[800]),
/*        
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:8.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonDataItemTitleText("Bilhete", widget._usuariocampanhasorteioticketVO['ticket'], color: Colors.blue[800]),
                            
                            Text(widget._usuariocampanhasorteioticketVO['ticket'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                            Text("Titulo principal" ,
                                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                            Text(widget._usuariocampanhasorteioticketVO['statusdesc'].toUpperCase(),
                                style: TextStyle(fontSize: 16, color: Colors.red)),
                            Text(widget._usuariocampanhasorteioticketVO['id'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                            Text(widget._usuariocampanhasorteioticketVO['iduscs'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                            Text(widget._usuariocampanhasorteioticketVO['status'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                            Text(widget._usuariocampanhasorteioticketVO['dataCadastro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                            Text(widget._usuariocampanhasorteioticketVO['dataAtualizacao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                           
                          ],
                        ),
                    ),

                  ],
                ),
//                SizedBox(height: 10,),
//                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,)
              ],
            ),
          ),
        )
*/        
    );
  }
}

