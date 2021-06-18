import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/campanhasorteio/CampanhaSorteioVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CampanhaSorteioVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CampanhaSorteioVOPost.fromJson(json.decode(response.body));
  });
}

class CampanhaSorteioPageCRUD extends StatefulWidget {


  CampanhaSorteioVOPost campanhasorteioVO;

  CampanhaSorteioPageCRUD({this.campanhasorteioVO});

  @override
  _CampanhaSorteioPageCRUDState createState() => _CampanhaSorteioPageCRUDState();
}

class _CampanhaSorteioPageCRUDState extends State<CampanhaSorteioPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecidCampanha = new TextEditingController();
  TextEditingController tecnome = new TextEditingController();
  TextEditingController tecurlRegulamento = new TextEditingController();
  TextEditingController tecpremio = new TextEditingController();
  TextEditingController tecdataInicioSorteio = new TextEditingController();
  TextEditingController tecdataFimSorteio = new TextEditingController();
  TextEditingController tecnuMaxTicketSorteio = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.campanhasorteioVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.campanhasorteioVO.id;
    tecidCampanha.text = _iscadastro ? '' : widget.campanhasorteioVO.idCampanha;
    tecnome.text = _iscadastro ? '' : widget.campanhasorteioVO.nome;
    tecurlRegulamento.text = _iscadastro ? '' : widget.campanhasorteioVO.urlRegulamento;
    tecpremio.text = _iscadastro ? '' : widget.campanhasorteioVO.premio;
    tecdataInicioSorteio.text = _iscadastro ? '' : widget.campanhasorteioVO.dataInicioSorteio;
    tecdataFimSorteio.text = _iscadastro ? '' : widget.campanhasorteioVO.dataFimSorteio;
    tecnuMaxTicketSorteio.text = _iscadastro ? '' : widget.campanhasorteioVO.nuMaxTicketSorteio;
    tecstatus.text = _iscadastro ? '' : widget.campanhasorteioVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.campanhasorteioVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.campanhasorteioVO.dataAtualizacao;

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

    List<Widget> _lstCamposCampanhaSorteio = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID da campanha sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecidCampanha, tit: TextInputType.text, label: "ID da campanha"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecnome, tit: TextInputType.text, label: "Nome do sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecurlRegulamento, tit: TextInputType.text, label: "URL regulamento do sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecpremio, tit: TextInputType.text, label: "Prêmio do sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecdataInicioSorteio, tit: TextInputType.text, label: "Data de início"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecdataFimSorteio, tit: TextInputType.text, label: "Data de término"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecnuMaxTicketSorteio, tit: TextInputType.text, label: "Máximo de tickets"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCampanhaSorteio.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          CampanhaSorteioVOPost newPost = new CampanhaSorteioVOPost(
              tokenid: _token,
              id: widget.campanhasorteioVO == null ? 0: widget.campanhasorteioVO.id,
              idCampanha: tecidCampanha.text, 
              nome: tecnome.text, 
              urlRegulamento: tecurlRegulamento.text, 
              premio: tecpremio.text, 
              dataInicioSorteio: tecdataInicioSorteio.text, 
              dataFimSorteio: tecdataFimSorteio.text, 
              nuMaxTicketSorteio: tecnuMaxTicketSorteio.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirCampanhaSorteio.php' : '${_urlControlador}appAtualizarCampanhaSorteio.php';
    CampanhaSorteioVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposCampanhaSorteio
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
