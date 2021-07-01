import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/registroindicacao/RegistroIndicacaoVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<RegistroIndicacaoVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return RegistroIndicacaoVOPost.fromJson(json.decode(response.body));
  });
}

class RegistroIndicacaoPageCRUD extends StatefulWidget {


  RegistroIndicacaoVOPost registroindicacaoVO;

  RegistroIndicacaoPageCRUD({this.registroindicacaoVO});

  @override
  _RegistroIndicacaoPageCRUDState createState() => _RegistroIndicacaoPageCRUDState();
}

class _RegistroIndicacaoPageCRUDState extends State<RegistroIndicacaoPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecidUsuarioPromotor = new TextEditingController();
  TextEditingController tecidUsuarioIndicado = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();
  /*
  @override
  @deprecated
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    tecid.text = widget.registroindicacao_full['id'];
    tecidUsuarioPromotor.text = widget.registroindicacao_full['idUsuarioPromotor'];
    tecidUsuarioIndicado.text = widget.registroindicacao_full['idUsuarioIndicado'];
    tecstatus.text = widget.registroindicacao_full['status'];
    tecdataCadastro.text = widget.registroindicacao_full['dataCadastro'];
    tecdataAtualizacao.text = widget.registroindicacao_full['dataAtualizacao'];
  }
   */

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.registroindicacaoVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.registroindicacaoVO.id;
    tecidUsuarioPromotor.text = _iscadastro ? '' : widget.registroindicacaoVO.idUsuarioPromotor;
    tecidUsuarioIndicado.text = _iscadastro ? '' : widget.registroindicacaoVO.idUsuarioIndicado;
    tecstatus.text = _iscadastro ? '' : widget.registroindicacaoVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.registroindicacaoVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.registroindicacaoVO.dataAtualizacao;

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

    List<Widget> _lstCamposRegistroIndicacao = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposRegistroIndicacao.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID Registro Indicação"));
    _lstCamposRegistroIndicacao.add(criarWidgetEntry(tec: tecidUsuarioPromotor, tit: TextInputType.text, label: "ID do usuário Promotor"));
    _lstCamposRegistroIndicacao.add(criarWidgetEntry(tec: tecidUsuarioIndicado, tit: TextInputType.text, label: "ID do usuário Indicado"));
    _lstCamposRegistroIndicacao.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposRegistroIndicacao.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposRegistroIndicacao.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposRegistroIndicacao.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          RegistroIndicacaoVOPost newPost = new RegistroIndicacaoVOPost(
              tokenid: _token,
              id: widget.registroindicacaoVO == null ? 0: widget.registroindicacaoVO.id,
              idUsuarioPromotor: tecidUsuarioPromotor.text, 
              idUsuarioIndicado: tecidUsuarioIndicado.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirRegistroIndicacao.php' : '${_urlControlador}appAtualizarRegistroIndicacao.php';
    RegistroIndicacaoVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposRegistroIndicacao
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



