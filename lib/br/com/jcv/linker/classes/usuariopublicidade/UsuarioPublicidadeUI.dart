import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/UsuarioPublicidadePageCRUD.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/UsuarioPublicidadeShowPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/UsuarioPublicidadeVOPost.dart';
import '../style/text_styles.dart';
import '../style/icons.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class UsuarioPublicidadeUI extends StatefulWidget {

  dynamic _usuariopublicidadeVO;

  UsuarioPublicidadeUI(this._usuariopublicidadeVO);

  @override
  _UsuarioPublicidadeUIState createState() => _UsuarioPublicidadeUIState();
}

class _UsuarioPublicidadeUIState extends State<UsuarioPublicidadeUI> {

  String _token;
  String _urlControlador;
  bool _isVisibleActionBtn = false;
  String _uspuid;

  @override
  void initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  Future<Map> _realizarCancelarClick() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appUsuarioPublicidadeCancelar.php?tokenid=$_token&uspuid=$_uspuid';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future<Map> _realizarHabilitarClick() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appUsuarioPublicidadeHabilitar.php?tokenid=$_token&uspuid=$_uspuid';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
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
            CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){
              UsuarioPublicidadeVOPost uspuvopost = new UsuarioPublicidadeVOPost();
              uspuvopost.id = widget._usuariopublicidadeVO['id'].toString();
              uspuvopost.id_usuario = widget._usuariopublicidadeVO['id_usuario'].toString();
              uspuvopost.titulo = widget._usuariopublicidadeVO['titulo'];
              uspuvopost.descricao = widget._usuariopublicidadeVO['descricao'];
              uspuvopost.dataInicio = widget._usuariopublicidadeVO['dataInicio'];
              uspuvopost.dataTermino = widget._usuariopublicidadeVO['dataTermino'];
              uspuvopost.vlNormal = widget._usuariopublicidadeVO['vlNormal'].toString();
              uspuvopost.vlPromo = widget._usuariopublicidadeVO['vlPromo'].toString();
              uspuvopost.observacao = widget._usuariopublicidadeVO['observacao'];
              // Navega para a pagina UsuarioPublicidadePageCRUD Solicitada ao clicar no botão Editar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new UsuarioPublicidadePageCRUD(usuariopublicidadeVO: uspuvopost),
                )
              );
            }),
            CommonFlatButtonFunction(Icon(Icons.remove_red_eye, color: Colors.white), "Preview", (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new UsuarioPublicidadeShowPage(widget._usuariopublicidadeVO),
                )
              );
            }),
            widget._usuariopublicidadeVO['status'] == "A" 
            ? CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Cancelar", ()  {
              CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
                context: context,
                icon: iconDialogQuestion,
                msg: "Tem certeza de CANCELAR este item?",
                textYes: "Sim",
                textNo: "Não",
              );
              csdyn.showDialogYesNo().then((mapa) async {
              if(csdyn.getChoice() == 'Y'){
                  _uspuid = widget._usuariopublicidadeVO['id'].toString();
                  Map mapa  = await _realizarCancelarClick();
                  CommonShowDialogYesNo retorno = await new CommonShowDialogYesNo(
                    context: context,
                    icon: mapa['msgcode'] == 'MSG-0001' ? iconReturnBackendSuccess : iconReturnBackendFail,
                    msg: mapa['msgcodeString'],
                  ).showDialogYesNo();
                } /*getChoice() */
              });
            })
            : CommonFlatButtonFunction(Icon(Icons.check_circle, color: Colors.white), "Habilitar", (){
              CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
                context: context,
                icon: iconDialogQuestion,
                msg: "Tem certeza de HABILITAR este item?",
                textYes: "Sim",
                textNo: "Não",
              );
              csdyn.showDialogYesNo().then((mapa) async {
              if(csdyn.getChoice() == 'Y'){
                  _uspuid = widget._usuariopublicidadeVO['id'].toString();
                  Map mapa  = await _realizarHabilitarClick();
                  CommonShowDialogYesNo retorno = await new CommonShowDialogYesNo(
                    context: context,
                    icon: mapa['msgcode'] == 'MSG-0001' ? iconReturnBackendSuccess : iconReturnBackendFail,
                    msg: mapa['msgcodeString'],
                  ).showDialogYesNo();
                } /*getChoice() */
              });              
            }),
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
                    new CommonImageCircle("no-user.png"
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget._usuariopublicidadeVO['id'].toString() ,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        Container(
                          width: screenWidth * 0.55,
                          child: Text(widget._usuariopublicidadeVO['titulo'] ,
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        ),
                        Text(widget._usuariopublicidadeVO['statusdesc'].toUpperCase(),
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                        Container(
                          width: screenWidth * 0.55,
                          child: Text(widget._usuariopublicidadeVO['descricao'] ,style: uiTextStylePadrao),
                        ),
                        Container(
                          width: screenWidth * 0.55,
                          child: Text(widget._usuariopublicidadeVO['observacao'] ,style: uiTextStylePadrao),
                        ),
                        Text("Preço Original: " + widget._usuariopublicidadeVO['vlNormalMoeda'] ,style: uiTextStylePadrao),
                        Text("Preço Promocional: " + widget._usuariopublicidadeVO['vlPromoMoeda'] ,style: uiTextStylePadrao),
                        Text("Inicia em "+widget._usuariopublicidadeVO['dataInicio'] ,style: uiTextStylePadrao),
                        Text("Parar em " + widget._usuariopublicidadeVO['dataTermino'] ,style: uiTextStylePadrao),
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
                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,)
              ],
            ),
          ),
        )
    );
  }
}
