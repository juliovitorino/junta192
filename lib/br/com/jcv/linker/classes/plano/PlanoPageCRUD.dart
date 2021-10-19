import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/plano/PlanoVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<PlanoVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return PlanoVOPost.fromJson(json.decode(response.body));
  });
}

class PlanoPageCRUD extends StatefulWidget {


  PlanoVOPost planoVO;

  PlanoPageCRUD({this.planoVO});

  @override
  _PlanoPageCRUDState createState() => _PlanoPageCRUDState();
}

class _PlanoPageCRUDState extends State<PlanoPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecnome = new TextEditingController();
  TextEditingController tecpermissao = new TextEditingController();
  TextEditingController tecvalor = new TextEditingController();
  TextEditingController tectipo = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();
  /*
  @override
  @deprecated
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    tecid.text = widget.plano_full['id'];
    tecnome.text = widget.plano_full['nome'];
    tecpermissao.text = widget.plano_full['permissao'];
    tecvalor.text = widget.plano_full['valor'];
    tectipo.text = widget.plano_full['tipo'];
    tecstatus.text = widget.plano_full['status'];
    tecdataCadastro.text = widget.plano_full['dataCadastro'];
    tecdataAtualizacao.text = widget.plano_full['dataAtualizacao'];
  }
   */

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.planoVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.planoVO.id;
    tecnome.text = _iscadastro ? '' : widget.planoVO.nome;
    tecpermissao.text = _iscadastro ? '' : widget.planoVO.permissao;
    tecvalor.text = _iscadastro ? '' : widget.planoVO.valor;
    tectipo.text = _iscadastro ? '' : widget.planoVO.tipo;
    tecstatus.text = _iscadastro ? '' : widget.planoVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.planoVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.planoVO.dataAtualizacao;

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

    List<Widget> _lstCamposPlano = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposPlano.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID do Plano"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tecnome, tit: TextInputType.text, label: "Nome do Plano"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tecpermissao, tit: TextInputType.text, label: "Estruturas de Permissão do Plano"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tecvalor, tit: TextInputType.text, label: "Valor do Plano"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tectipo, tit: TextInputType.text, label: "Tipo do Plano"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposPlano.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposPlano.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          PlanoVOPost newPost = new PlanoVOPost(
              tokenid: _token,
              id: widget.planoVO == null ? 0: widget.planoVO.id,
              nome: tecnome.text, 
              permissao: tecpermissao.text, 
              valor: tecvalor.text, 
              tipo: tectipo.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirPlano.php' : '${_urlControlador}appAtualizarPlano.php';
    PlanoVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposPlano
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



