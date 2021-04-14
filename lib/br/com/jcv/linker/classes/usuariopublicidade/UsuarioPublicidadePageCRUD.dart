import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-datetime-dataentry.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/UsuarioPublicidadeVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<UsuarioPublicidadeVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return UsuarioPublicidadeVOPost.fromJson(json.decode(response.body));
  });
}

class UsuarioPublicidadePageCRUD extends StatefulWidget {


  UsuarioPublicidadeVOPost usuariopublicidadeVO;

  UsuarioPublicidadePageCRUD({this.usuariopublicidadeVO});

  @override
  _UsuarioPublicidadePageCRUDState createState() => _UsuarioPublicidadePageCRUDState();
}

class _UsuarioPublicidadePageCRUDState extends State<UsuarioPublicidadePageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tectitulo = new TextEditingController();
  TextEditingController tecdescricao = new TextEditingController();
  TextEditingController tecvlNormal = new TextEditingController();
  TextEditingController tecvlPromo = new TextEditingController();
  TextEditingController tecobservacao = new TextEditingController();
  CommonDateTimeDataentry cdteInicio = new CommonDateTimeDataentry(labelData: "Data de Início", labelHora: "Hora de Início",);
  CommonDateTimeDataentry cdteTermino = new CommonDateTimeDataentry(labelData: "Data de Término", labelHora: "Hora de Término",);

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _iscadastro = (widget.usuariopublicidadeVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tectitulo.text = _iscadastro ? '' : widget.usuariopublicidadeVO.titulo;
    tecdescricao.text = _iscadastro ? '' : widget.usuariopublicidadeVO.descricao;
    tecvlNormal.text = _iscadastro ? '' : widget.usuariopublicidadeVO.vlNormal;
    tecvlPromo.text = _iscadastro ? '' : widget.usuariopublicidadeVO.vlPromo;
    tecobservacao.text = _iscadastro ? '' : widget.usuariopublicidadeVO.observacao;
    if(!_iscadastro){
      cdteInicio.setDateTime(widget.usuariopublicidadeVO.dataInicio);
      cdteTermino.setDateTime(widget.usuariopublicidadeVO.dataTermino);
    }

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

    List<Widget> _lstCamposUsuarioPublicidade = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposUsuarioPublicidade.add(criarWidgetEntry(tec: tectitulo, tit: TextInputType.text, label: "Título da publicidade"));
    _lstCamposUsuarioPublicidade.add(criarWidgetEntry(tec: tecdescricao, tit: TextInputType.text, label: "Descrição geral"));
    _lstCamposUsuarioPublicidade.add(cdteInicio);
    _lstCamposUsuarioPublicidade.add(cdteTermino);
    _lstCamposUsuarioPublicidade.add(criarWidgetEntry(tec: tecvlNormal, tit: TextInputType.text, label: "Valor do produto/serviço"));
    _lstCamposUsuarioPublicidade.add(criarWidgetEntry(tec: tecvlPromo, tit: TextInputType.text, label: "Valor promocional produto/serviço"));
    _lstCamposUsuarioPublicidade.add(criarWidgetEntry(tec: tecobservacao, tit: TextInputType.text, label: "Observação"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposUsuarioPublicidade.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
/*
print("tokenid:"+  _token);
print("id:"+  widget.usuariopublicidadeVO.id.toString());
print("titulo:"+  tectitulo.text);
print("descricao:"+  tecdescricao.text); 
print("dataInicio:"+  cdteInicio.getDateTimeDataentry()); 
print("dataTermino:"+  cdteTermino.getDateTimeDataentry()); 
print("vlNormal:"+  tecvlNormal.text);
print("vlPromo:"+ tecvlPromo.text); 
print("observacao: " + tecobservacao.text);
*/
          UsuarioPublicidadeVOPost newPost = new UsuarioPublicidadeVOPost(
              tokenid: _token,
              id: _iscadastro ? "0": widget.usuariopublicidadeVO.id.toString(),
              titulo: tectitulo.text, 
              descricao: tecdescricao.text, 
              dataInicio: cdteInicio.getDateTimeDataentry(), 
              dataTermino: cdteTermino.getDateTimeDataentry(), 
              vlNormal: tecvlNormal.text, 
              vlPromo: tecvlPromo.text, 
              observacao: tecobservacao.text, 
          );
          String _urlcrud = _iscadastro ? '${_urlControlador}appInserirUsuarioPublicidade.php' : '${_urlControlador}appAtualizarUsuarioPublicidade.php';
print("urlcrud => " + _urlcrud);
          UsuarioPublicidadeVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposUsuarioPublicidade
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



