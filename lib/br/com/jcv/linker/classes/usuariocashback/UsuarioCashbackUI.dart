import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-outlinebutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-outlinebutton-pageroute.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariocashback/UsuarioCashbackQRCodeIDCliente.dart';

class UsuarioCashbackUI extends StatefulWidget {

  dynamic _usuariocashbackVO;
  Color color;

  UsuarioCashbackUI(this._usuariocashbackVO, {this.color=Colors.grey});

  @override
  _UsuarioCashbackUIState createState() => _UsuarioCashbackUIState();
}

class _UsuarioCashbackUIState extends State<UsuarioCashbackUI> {

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
          color:  widget.color,
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
                        Text('O cliente recebe de volta ' + widget._usuariocashbackVO['percentualFmt'] + "%",
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black87)),
                        SizedBox(height: 10,),
                        Text('Resgate a partir de ',
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black87)),
                        Text(widget._usuariocashbackVO['vlMinimoResgateMoeda'] ,
                            style: TextStyle(fontSize: 26, color: Colors.black)),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CommonOutlineButtonFunction(Icon(Icons.money_off), "Desativar", (){} ),
                    CommonOutlineButtonPageRoute(Icon(Icons.monetization_on), "Vale-Presente", new UsuarioCashbackQRCodeIDCliente())
                  ],
                ),

              ],
            ),
          ),
        )
    );
  }
}

/*
Card(
          child: Padding(
            padding: EdgeInsets.only(left:8.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget._usuariocashbackVO['vlMinimoResgateMoeda']),
                Text(widget._usuariocashbackVO['percentualFmt'] + "%"),
                Text(widget._usuariocashbackVO['obs']),
                Text(widget._usuariocashbackVO['statusdesc']),
                Text(widget._usuariocashbackVO['dataCadastro']),
                Text(widget._usuariocashbackVO['dataAtualizacao']),

              ],
            ),
          ),
        )
*/

/*
                Text(widget._usuariocashbackVO['id']),
                Text(widget._usuariocashbackVO['id_usuario']),
                Text(widget._usuariocashbackVO['contadorStar_1']),
                Text(widget._usuariocashbackVO['contadorStar_2']),
                Text(widget._usuariocashbackVO['contadorStar_3']),
                Text(widget._usuariocashbackVO['contadorStar_4']),
                Text(widget._usuariocashbackVO['contadorStar_5']),
                Text(widget._usuariocashbackVO['ratingCalculado']),
*/                
