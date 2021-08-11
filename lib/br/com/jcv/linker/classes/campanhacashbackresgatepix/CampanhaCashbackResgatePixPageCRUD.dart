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


  dynamic saldoCashbackCCVO;

  CampanhaCashbackResgatePixPageCRUD(this.saldoCashbackCCVO);

  @override
  _CampanhaCashbackResgatePixPageCRUDState createState() => _CampanhaCashbackResgatePixPageCRUDState();
}

class _CampanhaCashbackResgatePixPageCRUDState extends State<CampanhaCashbackResgatePixPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  //bool _iscadastro = true;

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tectipoChavePix = new TextEditingController();
  TextEditingController tecchavePix = new TextEditingController();
  TextEditingController tecvalorResgate = new TextEditingController();

  @override
  void initState(){
    _value = 0;
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    //_iscadastro = (widget._saldoCashbackCCVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    /*
    tectipoChavePix.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.tipoChavePix;
    tecchavePix.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.chavePix;
    tecvalorResgate.text = _iscadastro ? '' : widget.campanhacashbackresgatepixVO.valorResgate;
    */

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

    DropdownButton _itemTipoPix() => DropdownButton<int>(
      value: _value,
      isExpanded: true,
      onChanged: (value){
        setState(() {
         _value = value; 
        });
      },
      items: [
        DropdownMenuItem(
          value: 0,
          child: Text("CPF"),
        ),
        DropdownMenuItem(
          value: 1,
          child: Text("CNPJ"),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("Celular"),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text("Email"),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text("Chave Aleatória"),
        ),
      ],
    );    

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    //_lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tectipoChavePix, tit: TextInputType.text, label: "Tipo da Chave PIX"));
    _lstCamposCampanhaCashbackResgatePix.add(        
      Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: _itemTipoPix()
        )
    );
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecchavePix, tit: TextInputType.text, label: "Chave PIX"));
    _lstCamposCampanhaCashbackResgatePix.add(criarWidgetEntry(tec: tecvalorResgate, tit: TextInputType.numberWithOptions(decimal: true), label: "Valor Pretendido a Resgatar"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCampanhaCashbackResgatePix.add( 
      new CommomActionButton(titulo: 'Salvar Pedido', 
          onpressed: () async {
          CampanhaCashbackResgatePixVOPost newPost = new CampanhaCashbackResgatePixVOPost(
              tokenid: _token,
              //id: widget.campanhacashbackresgatepixVO == null ? 0: widget.campanhacashbackresgatepixVO.id,
              idUsuarioDevedor: widget.saldoCashbackCCVO['id_dono'], 
              //idUsuarioSolicitante: tecidUsuarioSolicitante.text, 
//              tipoChavePix: tectipoChavePix.text, 
              tipoChavePix: _value.toString(), 
              chavePix: tecchavePix.text, 
              valorResgate: tecvalorResgate.text, 
          );

    String _urlcrud ='${_urlControlador}appInserirCampanhaCashbackResgatePix.php';
    CampanhaCashbackResgatePixVOPost p = await createPost('$_urlcrud', body: newPost.toMap());
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
        title: Text("Adicionar PIX"),
      ),
      body: _sceditview,
    );
  }
}



