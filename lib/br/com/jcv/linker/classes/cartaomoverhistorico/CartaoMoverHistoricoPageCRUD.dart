import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/cartaomoverhistorico/CartaoMoverHistoricoVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CartaoMoverHistoricoVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CartaoMoverHistoricoVOPost.fromJson(json.decode(response.body));
  });
}

class CartaoMoverHistoricoPageCRUD extends StatefulWidget {


  CartaoMoverHistoricoVOPost cartaomoverhistoricoVO;

  CartaoMoverHistoricoPageCRUD({this.cartaomoverhistoricoVO});

  @override
  _CartaoMoverHistoricoPageCRUDState createState() => _CartaoMoverHistoricoPageCRUDState();
}

class _CartaoMoverHistoricoPageCRUDState extends State<CartaoMoverHistoricoPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecidCartao = new TextEditingController();
  TextEditingController tecidUsuarioDoador = new TextEditingController();
  TextEditingController tecidUsuarioReceptor = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.cartaomoverhistoricoVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.id;
    tecidCartao.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.idCartao;
    tecidUsuarioDoador.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.idUsuarioDoador;
    tecidUsuarioReceptor.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.idUsuarioReceptor;
    tecstatus.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.cartaomoverhistoricoVO.dataAtualizacao;

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

    List<Widget> _lstCamposCartaoMoverHistorico = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID do hsitorico cartão transferido"));
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecidCartao, tit: TextInputType.text, label: "ID do cartão"));
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecidUsuarioDoador, tit: TextInputType.text, label: "ID do usuário doador"));
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecidUsuarioReceptor, tit: TextInputType.text, label: "ID do usuário receptor"));
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposCartaoMoverHistorico.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCartaoMoverHistorico.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          CartaoMoverHistoricoVOPost newPost = new CartaoMoverHistoricoVOPost(
              tokenid: _token,
              id: widget.cartaomoverhistoricoVO == null ? 0: widget.cartaomoverhistoricoVO.id,
              idCartao: tecidCartao.text, 
              idUsuarioDoador: tecidUsuarioDoador.text, 
              idUsuarioReceptor: tecidUsuarioReceptor.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirCartaoMoverHistorico.php' : '${_urlControlador}appAtualizarCartaoMoverHistorico.php';
    CartaoMoverHistoricoVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposCartaoMoverHistorico
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



