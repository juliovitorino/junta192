import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-asset-image-circle.dart';

class UsuarioNotificacaoUI extends StatefulWidget {

  dynamic _usuarionotificacaoVO;

  UsuarioNotificacaoUI(this._usuarionotificacaoVO);

  @override
  _UsuarioNotificacaoUIState createState() => _UsuarioNotificacaoUIState();
}

class _UsuarioNotificacaoUIState extends State<UsuarioNotificacaoUI> {

  String _token;
  String _urlControlador;

  @override
  initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left:8.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new CommonAssetImageCircle(widget._usuarionotificacaoVO['icone']
                        ,heightcic: 32
                        ,widthcic: 32
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalDirection: VerticalDirection.up,
                      children: <Widget>[
                        Text(widget._usuarionotificacaoVO['dataCadastro'] ,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Text(widget._usuarionotificacaoVO['notificacao'] ,
                    style: TextStyle(color: Colors.black))
              ],
            ),
          ),
        )
    );
  }
}
