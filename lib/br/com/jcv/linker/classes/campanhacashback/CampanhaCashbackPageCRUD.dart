import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashback/CampanhaCashbackVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CampanhaCashbackVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CampanhaCashbackVOPost.fromJson(json.decode(response.body));
  });
}

class CampanhaCashbackPageCRUD extends StatefulWidget {


  CampanhaCashbackVOPost campanhacashbackVO;

  CampanhaCashbackPageCRUD({this.campanhacashbackVO});

  @override
  _CampanhaCashbackPageCRUDState createState() => _CampanhaCashbackPageCRUDState();
}

class _CampanhaCashbackPageCRUDState extends State<CampanhaCashbackPageCRUD> {

  int _value;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;
  TimeOfDay _timedt = new TimeOfDay.now();

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tecpercentual = new TextEditingController();
  TextEditingController tecdataTermino = new TextEditingController();
  TextEditingController techoraTermino = new TextEditingController();
  TextEditingController tecobs = new TextEditingController();

  String _parseDate(String strDate) {
    //           1
    // 0123456789012345678
    // 03-08-2019 11:59:15
    // 2019-09-03 11:78:87.3642864
    return strDate.substring(8,10) +
    "-" +
    strDate.substring(5,7) +
    "-" +
    strDate.substring(0,4);
    //" " +
    //strDate.substring(11,19);

  }

  Future<Null> _selectDataTermino(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 1)),
        lastDate: new DateTime.now().add(new Duration(days: 365))
    );
    if(picked != null) setState(() => tecdataTermino.text = _parseDate(picked.toString()));
  }

  Future<Null> _selectHoraTermino(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _timedt,
    );
    if(picked != null && picked != _timedt) setState(() => techoraTermino.text = picked.format(context));
  }


  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _iscadastro = (widget.campanhacashbackVO == null || widget.campanhacashbackVO.id == '0');

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tecpercentual.text = _iscadastro ? '' : widget.campanhacashbackVO.percentual;
    tecobs.text = _iscadastro ? '' : widget.campanhacashbackVO.obs;
    tecdataTermino.text = _iscadastro ? '' : widget.campanhacashbackVO.dataTermino.substring(0,10);
    techoraTermino.text = _iscadastro ? '' : widget.campanhacashbackVO.dataTermino.substring(11,16);

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

    List<Widget> _lstCamposCampanhaCashback = [];

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposCampanhaCashback.add(criarWidgetEntry(tec: tecpercentual, tit: TextInputType.numberWithOptions(decimal: true), label: "Percentual"));
    //_lstCamposCampanhaCashback.add(criarWidgetEntry(tec: tecdataTermino, tit: TextInputType.text, label: "Data de término"));
    _lstCamposCampanhaCashback.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: (){ _selectDataTermino(context);},
              controller: tecdataTermino,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Data de Término",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0
            ),
          ),
        )
    );

    _lstCamposCampanhaCashback.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: (){_selectHoraTermino(context);},
              controller: techoraTermino,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Hora de Término",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0
            ),
          ),
        )
    );

    _lstCamposCampanhaCashback.add(criarWidgetEntry(tec: tecobs, tit: TextInputType.text, label: "Observação"));

    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposCampanhaCashback.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          CampanhaCashbackVOPost newPost = new CampanhaCashbackVOPost(
              tokenid: _token,
              id: widget.campanhacashbackVO == null ? '0': widget.campanhacashbackVO.id,
              id_campanha: widget.campanhacashbackVO == null ? 0 : widget.campanhacashbackVO.id_campanha,
              percentual: tecpercentual.text, 
              dataTermino: tecdataTermino.text + " " + techoraTermino.text + ":00", 
              obs: tecobs.text, 
          );
          String _urlcrud = _iscadastro ? '${_urlControlador}appInserirCampanhaCashback.php' : '${_urlControlador}appAtualizarCampanhaCashback.php';
          CampanhaCashbackVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposCampanhaCashback
              ),
            ),
          ],
        ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text(_iscadastro? "Nova Configuração" : "Editar"),
      ),
      body: _sceditview,
    );
  }
}
