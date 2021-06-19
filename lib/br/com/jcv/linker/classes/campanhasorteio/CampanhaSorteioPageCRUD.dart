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
//  TextEditingController tecidCampanha = new TextEditingController();
  TextEditingController tecnome = new TextEditingController();
  TextEditingController tecurlRegulamento = new TextEditingController();
  TextEditingController tecpremio = new TextEditingController();
  TextEditingController tecnuMaxTicketSorteio = new TextEditingController();
  
  @override
  void initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _iscadastro = false;
    if(widget.campanhasorteioVO == null || (widget.campanhasorteioVO != null && widget.campanhasorteioVO.id == "0")) 
    {
      _iscadastro = true;
    }

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
//    tecidCampanha.text = _iscadastro ? '' : widget.campanhasorteioVO.idCampanha;
    tecnome.text = _iscadastro ? '' : widget.campanhasorteioVO.nome;
    tecurlRegulamento.text = _iscadastro ? '' : widget.campanhasorteioVO.urlRegulamento;
    tecpremio.text = _iscadastro ? '' : widget.campanhasorteioVO.premio;
    tecnuMaxTicketSorteio.text = _iscadastro ? '' : widget.campanhasorteioVO.nuMaxTicketSorteio;
  
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
//    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecidCampanha, tit: TextInputType.text, label: "ID da campanha"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecnome, tit: TextInputType.text, label: "Nome do sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecurlRegulamento, tit: TextInputType.text, label: "URL regulamento do sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecpremio, tit: TextInputType.text, label: "Prêmio do sorteio"));
    _lstCamposCampanhaSorteio.add(criarWidgetEntry(tec: tecnuMaxTicketSorteio, tit: TextInputType.number, label: "Máximo de tickets"));
  
    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCampanhaSorteio.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          CampanhaSorteioVOPost newPost = new CampanhaSorteioVOPost(
              tokenid: _token,
              id: widget.campanhasorteioVO.id,
              idCampanha: widget.campanhasorteioVO.idCampanha, 
              nome: tecnome.text, 
              urlRegulamento: tecurlRegulamento.text, 
              premio: tecpremio.text, 
              nuMaxTicketSorteio: tecnuMaxTicketSorteio.text, 
          );
          String _urlcrud = _iscadastro ? '${_urlControlador}appInserirCampanhaSorteio.php' : '${_urlControlador}appAtualizarCampanhaSorteio.php';
print(_urlcrud);          
          CampanhaSorteioVOPost p = await createPost('$_urlcrud', body: newPost.toMap());
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
