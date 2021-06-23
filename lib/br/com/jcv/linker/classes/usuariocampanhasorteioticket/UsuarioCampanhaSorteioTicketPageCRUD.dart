import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/usuariocampanhasorteioticket/UsuarioCampanhaSorteioTicketVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<UsuarioCampanhaSorteioTicketVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return UsuarioCampanhaSorteioTicketVOPost.fromJson(json.decode(response.body));
  });
}

class UsuarioCampanhaSorteioTicketPageCRUD extends StatefulWidget {


  UsuarioCampanhaSorteioTicketVOPost usuariocampanhasorteioticketVO;

  UsuarioCampanhaSorteioTicketPageCRUD({this.usuariocampanhasorteioticketVO});

  @override
  _UsuarioCampanhaSorteioTicketPageCRUDState createState() => _UsuarioCampanhaSorteioTicketPageCRUDState();
}

class _UsuarioCampanhaSorteioTicketPageCRUDState extends State<UsuarioCampanhaSorteioTicketPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController teciduscs = new TextEditingController();
  TextEditingController tecticket = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();
  /*
  @override
  @deprecated
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    tecid.text = widget.usuariocampanhasorteioticket_full['id'];
    teciduscs.text = widget.usuariocampanhasorteioticket_full['iduscs'];
    tecticket.text = widget.usuariocampanhasorteioticket_full['ticket'];
    tecstatus.text = widget.usuariocampanhasorteioticket_full['status'];
    tecdataCadastro.text = widget.usuariocampanhasorteioticket_full['dataCadastro'];
    tecdataAtualizacao.text = widget.usuariocampanhasorteioticket_full['dataAtualizacao'];
  }
   */

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.usuariocampanhasorteioticketVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.usuariocampanhasorteioticketVO.id;
    teciduscs.text = _iscadastro ? '' : widget.usuariocampanhasorteioticketVO.iduscs;
    tecticket.text = _iscadastro ? '' : widget.usuariocampanhasorteioticketVO.ticket;
    tecstatus.text = _iscadastro ? '' : widget.usuariocampanhasorteioticketVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.usuariocampanhasorteioticketVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.usuariocampanhasorteioticketVO.dataAtualizacao;

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

    List<Widget> _lstCamposUsuarioCampanhaSorteioTicket = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposUsuarioCampanhaSorteioTicket.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID Usuario Campanha Sorteio Ticket"));
    _lstCamposUsuarioCampanhaSorteioTicket.add(criarWidgetEntry(tec: teciduscs, tit: TextInputType.text, label: "ID Usuario Campanha Sorteio"));
    _lstCamposUsuarioCampanhaSorteioTicket.add(criarWidgetEntry(tec: tecticket, tit: TextInputType.text, label: "Número do Ticket"));
    _lstCamposUsuarioCampanhaSorteioTicket.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposUsuarioCampanhaSorteioTicket.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposUsuarioCampanhaSorteioTicket.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposUsuarioCampanhaSorteioTicket.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          UsuarioCampanhaSorteioTicketVOPost newPost = new UsuarioCampanhaSorteioTicketVOPost(
              tokenid: _token,
              id: widget.usuariocampanhasorteioticketVO == null ? 0: widget.usuariocampanhasorteioticketVO.id,
              iduscs: teciduscs.text, 
              ticket: tecticket.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirUsuarioCampanhaSorteioTicket.php' : '${_urlControlador}appAtualizarUsuarioCampanhaSorteioTicket.php';
    UsuarioCampanhaSorteioTicketVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposUsuarioCampanhaSorteioTicket
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
