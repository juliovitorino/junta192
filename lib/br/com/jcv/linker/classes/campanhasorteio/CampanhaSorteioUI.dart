import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class CampanhaSorteioUI extends StatefulWidget {

  dynamic _campanhasorteioVO;

  CampanhaSorteioUI(this._campanhasorteioVO);

  @override
  _CampanhaSorteioUIState createState() => _CampanhaSorteioUIState();
}

class _CampanhaSorteioUIState extends State<CampanhaSorteioUI> {

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

    String validade =  widget._campanhasorteioVO['dataComecoSorteio'] == null ? "Em aberto" : widget._campanhasorteioVO['dataComecoSorteio'] + " a " + widget._campanhasorteioVO['dataFimSorteio'];

    // monta dinamicamente os botoes de ação
    List<Widget> _lstBtnAcao = [];
    if(widget._campanhasorteioVO['status'] == "P") {
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.run_circle, color: Colors.white), "Ativar", (){}));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Apagar", (){}, color: Colors.red[800]));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}));
    }

    // campanha em status PRONTO PRA USO
    if(widget._campanhasorteioVO['status'] == "D") {
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.close, color: Colors.white), "Desativar", (){}, color: Colors.red[800]));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.pause, color: Colors.white), "Pausar", (){}));
      _lstBtnAcao.add(CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}));
    }

    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _lstBtnAcao,
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
                    //new CommonImageCircle("no-user.png"
                    //    ,heightcic: 64
                    //    ,widthcic: 64
                    //    ,bordercolorcic: Colors.transparent),
                    //SizedBox(width: 8,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonDataItemTitleText("Campanha Promocional (" + widget._campanhasorteioVO['id']  + "/" + widget._campanhasorteioVO['maxTickets'] + ")",
                            widget._campanhasorteioVO['nome']),
                          CommonDataItemTitleText("Status", widget._campanhasorteioVO['statusdesc'].toUpperCase(), color: Colors.red[800]),
                          CommonDataItemTitleText("URL Regulamento", widget._campanhasorteioVO['urlRegulamento'], color: Colors.blue[800]),
                          CommonDataItemTitleText("Prêmio deste sorteio", widget._campanhasorteioVO['premio']),
                          CommonDataItemTitleText("Validade", validade),
                          //Text(widget._campanhasorteioVO['statusdesc'].toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.red)),
                          //,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['id_campanha'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['urlRegulamento'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataComecoSorteio'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataFimSorteio'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['maxTickets'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['status'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataCadastro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(widget._campanhasorteioVO['dataAtualizacao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
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
