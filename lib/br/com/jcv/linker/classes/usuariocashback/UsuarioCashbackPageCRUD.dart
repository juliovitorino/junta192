import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/usuariocashback/UsuarioCashbackVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<UsuarioCashbackVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return UsuarioCashbackVOPost.fromJson(json.decode(response.body));
  });
}

class UsuarioCashbackPageCRUD extends StatefulWidget {


  UsuarioCashbackVOPost usuariocashbackVO;

  UsuarioCashbackPageCRUD({this.usuariocashbackVO});

  @override
  _UsuarioCashbackPageCRUDState createState() => _UsuarioCashbackPageCRUDState();
}

class _UsuarioCashbackPageCRUDState extends State<UsuarioCashbackPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

  // ============================================================================
  // inicializa os controladores de campos com os respectivos atributos
  // ============================================================================
  TextEditingController tecvlMinimoResgate = new TextEditingController();
  TextEditingController tecpercentual = new TextEditingController();
  TextEditingController tecobs = new TextEditingController();

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _iscadastro = (widget.usuariocashbackVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecvlMinimoResgate.text = _iscadastro ? '200.00' : widget.usuariocashbackVO.vlMinimoResgate;
    tecpercentual.text = _iscadastro ? '1.0' : widget.usuariocashbackVO.percentual;
    tecobs.text = _iscadastro ? 'Resgate permitido em dinheiro ou mercadorias ou serviços' : widget.usuariocashbackVO.obs;

  }

  // ===============================================
  // função que cria o widget  base entrada de dados
  // ===============================================
  Widget criarWidgetEntry({TextEditingController tec, TextInputType tit, String label}) => Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: TextField(
          controller: tec,
          keyboardType: tit,
          decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder()
            ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {

    List<Widget> _lstCamposUsuarioCashback = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposUsuarioCashback.add(criarWidgetEntry(tec: tecvlMinimoResgate, tit: TextInputType.numberWithOptions(decimal: true), label: "Resgatar a partir de R\$"));
    _lstCamposUsuarioCashback.add(criarWidgetEntry(tec: tecpercentual, tit: TextInputType.numberWithOptions(decimal: true), label: "Percentual (%)"));
    _lstCamposUsuarioCashback.add(criarWidgetEntry(tec: tecobs, tit: TextInputType.text, label: "Observação"));
    
    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposUsuarioCashback.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          UsuarioCashbackVOPost newPost = new UsuarioCashbackVOPost(
              tokenid: _token,
              vlMinimoResgate: tecvlMinimoResgate.text, 
              percentual: tecpercentual.text, 
              obs: tecobs.text, 
          );
          print(_token);
          print(tecvlMinimoResgate.text);
          print(tecpercentual.text);
          print(tecobs.text);

          String _urlcrud = _iscadastro ? '${_urlControlador}appInserirUsuarioCashback.php' : '${_urlControlador}appAtualizarUsuarioCashback.php';
          print(_urlcrud);
          UsuarioCashbackVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
            }
          );
        })      
    );

    SingleChildScrollView _sceditview = SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: _lstCamposUsuarioCashback
              ),
            ),
          ],
        ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text(_iscadastro? "Adicionar" : "Editar"),
      ),
      body: _sceditview,
    );
  }
}
