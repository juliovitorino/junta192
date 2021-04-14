import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/contente_heading.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/ads-supermercado-typeone-upload.dart';
import '../style/text_styles.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class UsuarioFinalPublicidadeUI extends StatefulWidget {

  dynamic _usuariopublicidadeVO;

  UsuarioFinalPublicidadeUI(this._usuariopublicidadeVO);

  @override
  _UsuarioFinalPublicidadeUIState createState() => _UsuarioFinalPublicidadeUIState();
}

class _UsuarioFinalPublicidadeUIState extends State<UsuarioFinalPublicidadeUI> {

  String _token;
  String _urlControlador;
   bool _isVisibleActionBtn = true;

  @override
  void initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  @override
  Widget build(BuildContext context) {

    Size size= MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    // Toolbar com botões de ação
    Widget _widActionBtn = Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CommonFlatButtonFunction(Icon(Icons.location_on, color: Colors.white), "Mapa", (){}),
            CommonFlatButtonFunction(Icon(Icons.add_to_photos, color: Colors.white), "Promoções", (){}),
          ],
        ),


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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new CommonImageCircle(widget._usuariopublicidadeVO['usuario']['urlfoto']
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: screenWidth * 0.55,
                          child: CommonContentHeading(heading: widget._usuariopublicidadeVO['usuario']['apelido'],
                            style: adsSupermercadoHeadingPadraoTS,)

                        ),
                        //Text(widget._usuariopublicidadeVO['id'].toString() ,
                        //    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        Text("Inicia em "+widget._usuariopublicidadeVO['dataInicio'] ,style: uiTextStylePadrao),
                        Text("Acaba às " + widget._usuariopublicidadeVO['dataTermino'] ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['id'].toString() ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['id_usuario'].toString() ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['titulo'] ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['dataRemover'] ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['status'] ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['dataCadastro'] ,style: uiTextStylePadrao),
                        //Text(widget._usuariopublicidadeVO['dataAtualizacao'] ,style: uiTextStylePadrao),
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
                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,),
                AdsSupermercadoTypeOneUpload(vopost: widget._usuariopublicidadeVO,)
              ],
            ),
          ),
        )
    );
  }
}
