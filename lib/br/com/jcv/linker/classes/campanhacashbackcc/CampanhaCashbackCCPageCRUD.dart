import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackcc/CampanhaCashbackCCVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CampanhaCashbackCCVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CampanhaCashbackCCVOPost.fromJson(json.decode(response.body));
  });
}

class CampanhaCashbackCCPageCRUD extends StatefulWidget {


  CampanhaCashbackCCVOPost campanhacashbackccVO;

  CampanhaCashbackCCPageCRUD({this.campanhacashbackccVO});

  @override
  _CampanhaCashbackCCPageCRUDState createState() => _CampanhaCashbackCCPageCRUDState();
}

class _CampanhaCashbackCCPageCRUDState extends State<CampanhaCashbackCCPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecid = new TextEditingController();
  TextEditingController tecid_cashback = new TextEditingController();
  TextEditingController tecid_campanha = new TextEditingController();
  TextEditingController tecid_usuario = new TextEditingController();
  TextEditingController tecid_dono = new TextEditingController();
  TextEditingController tecid_cfdi = new TextEditingController();
  TextEditingController tecdescricao = new TextEditingController();
  TextEditingController tecvlMinimo = new TextEditingController();
  TextEditingController tecpercentual = new TextEditingController();
  TextEditingController tecvlConsumo = new TextEditingController();
  TextEditingController tecvlCalcRecompensa = new TextEditingController();
  TextEditingController tectipoMovimento = new TextEditingController();
  TextEditingController tecnfe = new TextEditingController();
  TextEditingController tecnfehash = new TextEditingController();
  TextEditingController tecstatus = new TextEditingController();
  TextEditingController tecdataCadastro = new TextEditingController();
  TextEditingController tecdataAtualizacao = new TextEditingController();

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _iscadastro = (widget.campanhacashbackccVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecid.text = _iscadastro ? '' : widget.campanhacashbackccVO.id;
    tecid_cashback.text = _iscadastro ? '' : widget.campanhacashbackccVO.id_cashback;
    tecid_campanha.text = _iscadastro ? '' : widget.campanhacashbackccVO.id_campanha;
    tecid_usuario.text = _iscadastro ? '' : widget.campanhacashbackccVO.id_usuario;
    tecid_dono.text = _iscadastro ? '' : widget.campanhacashbackccVO.id_dono;
    tecid_cfdi.text = _iscadastro ? '' : widget.campanhacashbackccVO.id_cfdi;
    tecdescricao.text = _iscadastro ? '' : widget.campanhacashbackccVO.descricao;
    tecvlMinimo.text = _iscadastro ? '' : widget.campanhacashbackccVO.vlMinimo;
    tecpercentual.text = _iscadastro ? '' : widget.campanhacashbackccVO.percentual;
    tecvlConsumo.text = _iscadastro ? '' : widget.campanhacashbackccVO.vlConsumo;
    tecvlCalcRecompensa.text = _iscadastro ? '' : widget.campanhacashbackccVO.vlCalcRecompensa;
    tectipoMovimento.text = _iscadastro ? '' : widget.campanhacashbackccVO.tipoMovimento;
    tecnfe.text = _iscadastro ? '' : widget.campanhacashbackccVO.nfe;
    tecnfehash.text = _iscadastro ? '' : widget.campanhacashbackccVO.nfehash;
    tecstatus.text = _iscadastro ? '' : widget.campanhacashbackccVO.status;
    tecdataCadastro.text = _iscadastro ? '' : widget.campanhacashbackccVO.dataCadastro;
    tecdataAtualizacao.text = _iscadastro ? '' : widget.campanhacashbackccVO.dataAtualizacao;

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

    List<Widget> _lstCamposCampanhaCashbackCC = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecid, tit: TextInputType.text, label: "ID da Conta Corrente Cashback"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecid_cashback, tit: TextInputType.text, label: "ID da campanha x cashback"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecid_campanha, tit: TextInputType.text, label: "ID da campanha"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecid_usuario, tit: TextInputType.text, label: "ID do usuário"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecid_dono, tit: TextInputType.text, label: "ID do usuário dono da campanha"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecid_cfdi, tit: TextInputType.text, label: "ID do carimbo efetuado no cartão"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecdescricao, tit: TextInputType.text, label: "Cópia da descrição"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecvlMinimo, tit: TextInputType.text, label: "Valor para permitir cashback"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecpercentual, tit: TextInputType.text, label: "Cópia do perc. cashback"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecvlConsumo, tit: TextInputType.text, label: "Valor do consumo"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecvlCalcRecompensa, tit: TextInputType.text, label: "Valor da recompensa"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tectipoMovimento, tit: TextInputType.text, label: "Tipo do movimento"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecnfe, tit: TextInputType.text, label: "NF Eletrônica"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecnfehash, tit: TextInputType.text, label: "Hash NFE"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecstatus, tit: TextInputType.text, label: "Status"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecdataCadastro, tit: TextInputType.text, label: "Data de Cadastro"));
    _lstCamposCampanhaCashbackCC.add(criarWidgetEntry(tec: tecdataAtualizacao, tit: TextInputType.text, label: "Data de Atualização"));


    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCampanhaCashbackCC.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          CampanhaCashbackCCVOPost newPost = new CampanhaCashbackCCVOPost(
              tokenid: _token,
              id: widget.campanhacashbackccVO == null ? 0: widget.campanhacashbackccVO.id,
              id_cashback: tecid_cashback.text, 
              id_campanha: tecid_campanha.text, 
              id_usuario: tecid_usuario.text, 
              id_dono: tecid_dono.text, 
              id_cfdi: tecid_cfdi.text, 
              descricao: tecdescricao.text, 
              vlMinimo: tecvlMinimo.text, 
              percentual: tecpercentual.text, 
              vlConsumo: tecvlConsumo.text, 
              vlCalcRecompensa: tecvlCalcRecompensa.text, 
              tipoMovimento: tectipoMovimento.text, 
              nfe: tecnfe.text, 
              nfehash: tecnfehash.text, 
              status: tecstatus.text, 
              dataCadastro: tecdataCadastro.text, 
              dataAtualizacao: tecdataAtualizacao.text, 
          );
    String _urlcrud = _iscadastro ? '${_urlControlador}appInserirCampanhaCashbackCC.php' : '${_urlControlador}appAtualizarCampanhaCashbackCC.php';
    CampanhaCashbackCCVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposCampanhaCashbackCC
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



