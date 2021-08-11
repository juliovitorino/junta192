import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class CartaoMoverHistoricoUI extends StatefulWidget {

  dynamic _cartaomoverhistoricoVO;

  CartaoMoverHistoricoUI(this._cartaomoverhistoricoVO);

  @override
  _CartaoMoverHistoricoUIState createState() => _CartaoMoverHistoricoUIState();
}

class _CartaoMoverHistoricoUIState extends State<CartaoMoverHistoricoUI> {

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
                    new CommonImageCircle(widget._cartaomoverhistoricoVO['usuarioDoador']['urlfoto']
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.blueAccent),
                    Icon(Icons.double_arrow_rounded, size: 48.0),
                    //Icon(Icons.arrow_right_alt, size: 48.0),
                    new CommonImageCircle(widget._cartaomoverhistoricoVO['usuarioReceptor']['urlfoto']
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.blueAccent),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Transferido de " + widget._cartaomoverhistoricoVO['usuarioDoador']['apelido'] 
                    + " para " 
                    + widget._cartaomoverhistoricoVO['usuarioReceptor']['apelido'],
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                    Text("em " + widget._cartaomoverhistoricoVO['dataCadastro'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
/*                        
                    Text(widget._cartaomoverhistoricoVO['statusdesc'].toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                    Text(widget._cartaomoverhistoricoVO['id'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(widget._cartaomoverhistoricoVO['idCartao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(widget._cartaomoverhistoricoVO['idUsuarioDoador'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(widget._cartaomoverhistoricoVO['idUsuarioReceptor'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(widget._cartaomoverhistoricoVO['status'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(widget._cartaomoverhistoricoVO['dataAtualizacao'] ,style: TextStyle(fontSize: 14, color: Colors.black)),
*/                    
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

























































































































































