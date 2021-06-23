import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/usuariocampanhasorteio/UsuarioCampanhaSorteioVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<UsuarioCampanhaSorteioVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return UsuarioCampanhaSorteioVOPost.fromJson(json.decode(response.body));
  });
}

class UsuarioCampanhaSorteioPageCRUD extends StatefulWidget {


  UsuarioCampanhaSorteioVOPost usuariocampanhasorteioVO;

  UsuarioCampanhaSorteioPageCRUD({this.usuariocampanhasorteioVO});

  @override
  _UsuarioCampanhaSorteioPageCRUDState createState() => _UsuarioCampanhaSorteioPageCRUDState();
}

class _UsuarioCampanhaSorteioPageCRUDState extends State<UsuarioCampanhaSorteioPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecidUsuario = new TextEditingController();
  TextEditingController tecidCampanhaSorteio = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();
  /*
  @override
  @deprecated
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    tecid.text = widget.usuariocampanhasorteio_full['id'];
    tecidUsuario.text = widget.usuariocampanhasorteio_full['idUsuario'];
    tecidCampanhaSorteio.text = widget.usuariocampanhasorteio_full['idCampanhaSorteio'];
    tecstatus.text = widget.usuariocampanhasorteio_full['status'];
    tecdataCadastro.text = widget.usuariocampanhasorteio_full['dataCadastro'];
    tecdataAtualizacao.text = widget.usuariocampanhasorteio_full['dataAtualizacao'];
  }
   */

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.usuariocampanhasorteioVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.usuariocampanhasorteioVO.id;
    tecidUsuario.text = _iscadastro ? '' : widget.usuariocampanhasorteioVO.idUsuario;
    tecidCampanhaSorteio.text = _iscadastro ? '' : widget.usuariocampanhasorteioVO.idCampanhaSorteio;
    tecstatus.text = _iscadastro ? '' : widget.usuariocampanhasorteioVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.usuariocampanhasorteioVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.usuariocampanhasorteioVO.dataAtualizacao;

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

    List<Widget> _lstCamposUsuarioCampanhaSorteio = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposUsuarioCampanhaSorteio.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID Usuario Campanha Sorteio"));
    _lstCamposUsuarioCampanhaSorteio.add(criarWidgetEntry(tec: tecidUsuario, tit: TextInputType.text, label: "ID do usuário"));
    _lstCamposUsuarioCampanhaSorteio.add(criarWidgetEntry(tec: tecidCampanhaSorteio, tit: TextInputType.text, label: "ID Campanha Sorteio"));
    _lstCamposUsuarioCampanhaSorteio.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposUsuarioCampanhaSorteio.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposUsuarioCampanhaSorteio.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposUsuarioCampanhaSorteio.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          UsuarioCampanhaSorteioVOPost newPost = new UsuarioCampanhaSorteioVOPost(
              tokenid: _token,
              id: widget.usuariocampanhasorteioVO == null ? 0: widget.usuariocampanhasorteioVO.id,
              idUsuario: tecidUsuario.text, 
              idCampanhaSorteio: tecidCampanhaSorteio.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirUsuarioCampanhaSorteio.php' : '${_urlControlador}appAtualizarUsuarioCampanhaSorteio.php';
    UsuarioCampanhaSorteioVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposUsuarioCampanhaSorteio
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
