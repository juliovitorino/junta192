import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariocampanhasorteioticket/UsuarioCampanhaSorteioTicketPage.dart';

class UsuarioCampanhaSorteioUI extends StatefulWidget {

  dynamic _usuariocampanhasorteioVO;

  UsuarioCampanhaSorteioUI(this._usuariocampanhasorteioVO);

  @override
  _UsuarioCampanhaSorteioUIState createState() => _UsuarioCampanhaSorteioUIState();
}

class _UsuarioCampanhaSorteioUIState extends State<UsuarioCampanhaSorteioUI> {

  String _token;
  String _urlControlador;
   bool _isVisibleActionBtn = true;

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
        CommonFlatButtonFunction(Icon(Icons.app_registration, color: Colors.white), "Ver Meus Bilhetes", (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new UsuarioCampanhaSorteioTicketPage(widget._usuariocampanhasorteioVO) ),
            );

        }),
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
                    Expanded(
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonDataItemTitleText("Você participa da campanha Sorteio", widget._usuariocampanhasorteioVO['campanhaSorteio']['nome']),
                            CommonDataItemTitleText("Concorre ao prêmio", widget._usuariocampanhasorteioVO['campanhaSorteio']['premio']),
                            CommonDataItemTitleText("Campanha Referência", widget._usuariocampanhasorteioVO['campanhaSorteio']['nome']),
                            CommonDataItemTitleText("URL Regulamento", widget._usuariocampanhasorteioVO['campanhaSorteio']['urlRegulamento'], color: Colors.blue[800]),
                            CommonDataItemTitleText("Patrocinado por", widget._usuariocampanhasorteioVO['usuario']['apelido']),
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
