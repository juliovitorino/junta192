import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarioautorizador/UsuarioAutorizadorPageCRUD.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarioautorizador/UsuarioAutorizadorVOPost.dart';

Future<UsuarioAutorizadorVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return UsuarioAutorizadorVOPost.fromJson(json.decode(response.body));
  });
}

class UsuarioAutorizadorUI extends StatefulWidget {

  dynamic _usuarioautorizadorVO;
  String campid;

  UsuarioAutorizadorUI(this.campid,this._usuarioautorizadorVO);

  @override
  _UsuarioAutorizadorUIState createState() => _UsuarioAutorizadorUIState();
}

class _UsuarioAutorizadorUIState extends State<UsuarioAutorizadorUI> {

  String _token;
  String _urlControlador;
  String _campid;
  String _onoff;
  bool _isVisibleActionBtn = false;

  @override
  initState() {
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _campid = widget.campid;
  }

  @override
  Widget build(BuildContext context) {
    CommonFlatButtonFunction _cfbfHabilitar = CommonFlatButtonFunction(Icon(Icons.check_circle, color: Colors.white,), "Habilitar", () async {
          UsuarioAutorizadorVOPost vopost = new UsuarioAutorizadorVOPost(
            tokenid: _token, 
            id: widget._usuarioautorizadorVO['id'].toString(),
            id_usuario: widget._usuarioautorizadorVO['id_usuario'].toString(),
            id_campanha: widget._usuarioautorizadorVO['id_campanha'].toString(),
            onoff: "1"
          );

          String _url = '${_urlControlador}appHabilitarUsuarioAutorizador.php';
          UsuarioAutorizadorVOPost p = await createPost('${_url}', body: vopost.toMap());
          Icon _icon = p.msgcode == 'MSG-0001' 
          ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
          : Icon(Icons.error, size: 120.0, color: Colors.red,);

          CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
            context: context,
            icon: _icon,
            msg: p.msgcodeString,
          );

          retorno.showDialogYesNo().then((onValue){
              if(retorno.getChoice() == 'Y'){
                Navigator.pop(context);
              }
            });
          
        });

    CommonFlatButtonFunction _cfbfdesabilitar = CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white,), "Desbilitar", () async {
          UsuarioAutorizadorVOPost vopost = new UsuarioAutorizadorVOPost(
            tokenid: _token, 
            id: widget._usuarioautorizadorVO['id'].toString(),
            id_usuario: widget._usuarioautorizadorVO['id_usuario'].toString(),
            id_campanha: widget._usuarioautorizadorVO['id_campanha'].toString(),
            onoff: "0"
          );

          String _url = '${_urlControlador}appHabilitarUsuarioAutorizador.php';
          UsuarioAutorizadorVOPost p = await createPost('${_url}', body: vopost.toMap());
          Icon _icon = p.msgcode == 'MSG-0001' 
          ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
          : Icon(Icons.error, size: 120.0, color: Colors.red,);

          CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
            context: context,
            icon: _icon,
            msg: p.msgcodeString,
          );

          retorno.showDialogYesNo().then((onValue){
              if(retorno.getChoice() == 'Y'){
                Navigator.pop(context);
              }
            });        
    });


    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Configurar", (){
          UsuarioAutorizadorVOPost vopost = new UsuarioAutorizadorVOPost(
            tokenid: _token, 
            id: widget._usuarioautorizadorVO['id'].toString(),
            id_campanha: widget.campid,
            tipo: widget._usuarioautorizadorVO['tipo'],
            permissao: "00",
            dataInicio: widget._usuarioautorizadorVO['dataInicio'],
            dataTermino: widget._usuarioautorizadorVO['dataTermino']
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new UsuarioAutorizadorPageCRUD(usuarioautorizadorVO: vopost) ),
          );


        }),
        widget._usuarioautorizadorVO['status'] == "A" ? _cfbfdesabilitar : _cfbfHabilitar,
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
                    new CommonImageCircle(widget._usuarioautorizadorVO['usuario']['urlfoto']
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget._usuarioautorizadorVO['usuario']['apelido'] ,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                        Text(widget._usuarioautorizadorVO['statusdesc'].toUpperCase(),
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                        Text('Qualificação: ' + widget._usuarioautorizadorVO['tipostr'] ),
                        Text('Permissão: ' + widget._usuarioautorizadorVO['permissaostr'] ),
                        Text('Liberado de ' + widget._usuarioautorizadorVO['dataInicio']),
                        Text('Encerra as ' + widget._usuarioautorizadorVO['dataTermino']),
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

/*
     Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left:8.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget._usuarioautorizadorVO['usuario']['apelido'].toString()),
                Text(widget._usuarioautorizadorVO['id'].toString()),
                Text(widget._usuarioautorizadorVO['id_usuario'].toString()),
                Text(widget._usuarioautorizadorVO['id_autorizador'].toString()),
                Text(widget._usuarioautorizadorVO['id_campanha'].toString()),
                Text(widget._usuarioautorizadorVO['tipo']),
                Text(widget._usuarioautorizadorVO['permissao']),
                Text(widget._usuarioautorizadorVO['status']),
                Text(widget._usuarioautorizadorVO['dataCadastro']),
                Text(widget._usuarioautorizadorVO['dataAtualizacao']),
                          Text('Liberado de ' + widget._usuarioautorizadorVO['dataInicio']),
                        Text('Encerra as ' + widget._usuarioautorizadorVO['dataTermino']),
            ],
            ),
          ),
        )
    );

*/