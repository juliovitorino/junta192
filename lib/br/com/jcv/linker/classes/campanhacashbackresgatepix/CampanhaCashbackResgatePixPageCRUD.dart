import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackresgatepix/CampanhaCashbackResgatePixVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CampanhaCashbackResgatePixVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CampanhaCashbackResgatePixVOPost.fromJson(json.decode(response.body));
  });
}

class CampanhaCashbackResgatePixPageCRUD extends StatefulWidget {


  CampanhaCashbackResgatePixVOPost campanhacashbackresgatepixVO;

  CampanhaCashbackResgatePixPageCRUD({this.campanhacashbackresgatepixVO});

  @override
  _CampanhaCashbackResgatePixPageCRUDState createState() => _CampanhaCashbackResgatePixPageCRUDState();
}

class _CampanhaCashbackResgatePixPageCRUDState extends State<CampanhaCashbackResgatePixPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecidCampanhaCashback = new TextEditingController();
  TextEditingController tecidUsuarioSolicitante = new TextEditingController();
  TextEditingController tectipoChavePix = new TextEditingController();
  TextEditingController tecchavePix = new TextEditingController();
  TextEditingController tecvalorResgate = new TextEditingController();
  TextEditingController tecautenticacaoBco = new TextEditingController();
  TextEditingController tecestagioRealTime = new TextEditingController();
  TextEditingController tecdtEstagioAnalise = new TextEditingController();
  TextEditingController tecdtEstagioFinanceiro = new TextEditingController();
  TextEditingController tecdtEstagioErro = new TextEditingController();
  TextEditingController tecdtEstagioTranfBco = new TextEditingController();
  TextEditingController tectxtLivreEstagioRT = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();

  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = (widget.campanhacashbackresgatepixVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.id;
    tecidCampanhaCashback.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.idCampanhaCashback;
    tecidUsuarioSolicitante.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.idUsuarioSolicitante;
    tectipoChavePix.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.tipoChavePix;
    tecchavePix.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.chavePix;
    tecvalorResgate.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.valorResgate;
    tecautenticacaoBco.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.autenticacaoBco;
    tecestagioRealTime.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.estagioRealTime;
    tecdtEstagioAnalise.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.dtEstagioAnalise;
    tecdtEstagioFinanceiro.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.dtEstagioFinanceiro;
    tecdtEstagioErro.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.dtEstagioErro;
    tecdtEstagioTranfBco.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.dtEstagioTranfBco;
    tectxtLivreEstagioRT.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.txtLivreEstagioRT;
    tecstatus.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.dataAtualizacao;

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

    List<Widget> _lstCamposCampanhaCashbackResgatePix = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID Resgate Cashback"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecidCampanhaCashback, tit: TextInputType.text, label: "ID Campanha x Cashback"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecidUsuarioSolicitante, tit: TextInputType.text, label: "ID do usuário solicitante"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tectipoChavePix, tit: TextInputType.text, label: "Tipo da Chave PIX"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecchavePix, tit: TextInputType.text, label: "Chave PIX"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecvalorResgate, tit: TextInputType.text, label: "Valor Pretendido a Resgatar"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecautenticacaoBco, tit: TextInputType.text, label: "Autenticação do Banco"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecestagioRealTime, tit: TextInputType.text, label: "Estágio Real Time"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecdtEstagioAnalise, tit: TextInputType.text, label: "Data Registro Estágio Análise"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecdtEstagioFinanceiro, tit: TextInputType.text, label: "Data Registro Estágio Financeiro"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecdtEstagioErro, tit: TextInputType.text, label: "Data Registro Estágio Erro"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecdtEstagioTranfBco, tit: TextInputType.text, label: "Data Registro Estágio Transferido Bco"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tectxtLivreEstagioRT, tit: TextInputType.text, label: "Texto Livre do Estagio RT"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCampanhaCashbackResgatePix.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          CampanhaCashbackResgatePixVOPost newPost = new CampanhaCashbackResgatePixVOPost(
              tokenid: _token,
              id: widget.campanhacashbackresgatepixVO == null ? 0: widget.campanhacashbackresgatepixVO.id,
              idCampanhaCashback: tecidCampanhaCashback.text, 
              idUsuarioSolicitante: tecidUsuarioSolicitante.text, 
              tipoChavePix: tectipoChavePix.text, 
              chavePix: tecchavePix.text, 
              valorResgate: tecvalorResgate.text, 
              autenticacaoBco: tecautenticacaoBco.text, 
              estagioRealTime: tecestagioRealTime.text, 
              dtEstagioAnalise: tecdtEstagioAnalise.text, 
              dtEstagioFinanceiro: tecdtEstagioFinanceiro.text, 
              dtEstagioErro: tecdtEstagioErro.text, 
              dtEstagioTranfBco: tecdtEstagioTranfBco.text, 
              txtLivreEstagioRT: tectxtLivreEstagioRT.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirCampanhaCashbackResgatePix.php' : '${_urlControlador}appAtualizarCampanhaCashbackResgatePix.php';
    CampanhaCashbackResgatePixVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposCampanhaCashbackResgatePix
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



