import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';

class CampanhaCashbackCCUI extends StatefulWidget {

  dynamic _campanhacashbackccVO;

  CampanhaCashbackCCUI(this._campanhacashbackccVO);

  @override
  _CampanhaCashbackCCUIState createState() => _CampanhaCashbackCCUIState();
}

class _CampanhaCashbackCCUIState extends State<CampanhaCashbackCCUI> {

  String _token;
  String _urlControlador;

  @override
  void initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left:8.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget._campanhacashbackccVO['dataCadastro'].substring(0,11)),
                      Text(widget._campanhacashbackccVO['vlConsumoMoeda'] + " x "+widget._campanhacashbackccVO['percentualFmt']+"%"),
                      Text(widget._campanhacashbackccVO['vlCalcRecompensaMoeda'] + "("+widget._campanhacashbackccVO['tipoMovimento']+")"),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black45, width: 1)
                    )
                  ),
                ),

               
                Text(widget._campanhacashbackccVO['descricao']),
/*                
                Text(widget._campanhacashbackccVO['id'].toString()),
                Text(widget._campanhacashbackccVO['id_cashback'].toString()),
                Text(widget._campanhacashbackccVO['id_campanha'].toString()),
                Text(widget._campanhacashbackccVO['id_usuario'].toString()),
                Text(widget._campanhacashbackccVO['id_dono'].toString()),
                Text(widget._campanhacashbackccVO['id_cfdi'].toString()),
                Text(widget._campanhacashbackccVO['vlMinimoMoeda']),
                Text(widget._campanhacashbackccVO['percentualFmt']),
                Text(widget._campanhacashbackccVO['vlConsumoMoeda']),
                Text(widget._campanhacashbackccVO['nfe']),
                Text(widget._campanhacashbackccVO['nfehash']),
                Text(widget._campanhacashbackccVO['status']),
                Text(widget._campanhacashbackccVO['dataAtualizacao']),
*/
              ],
            ),
          ),
        )
    );
  }
}
