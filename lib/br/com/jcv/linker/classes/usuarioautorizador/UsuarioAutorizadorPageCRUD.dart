import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/usuarioautorizador/UsuarioAutorizadorVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<UsuarioAutorizadorVOPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return UsuarioAutorizadorVOPost.fromJson(json.decode(response.body));
  });
}

class UsuarioAutorizadorPageCRUD extends StatefulWidget {

  UsuarioAutorizadorVOPost usuarioautorizadorVO;
  UsuarioAutorizadorPageCRUD({this.usuarioautorizadorVO});

  @override
  _UsuarioAutorizadorPageCRUDState createState() => _UsuarioAutorizadorPageCRUDState();
}

class _UsuarioAutorizadorPageCRUDState extends State<UsuarioAutorizadorPageCRUD> {

  String _valueTipo;
  String _valueQualAuto;
  String _token;
  String _urlControlador;
  bool _iscadastro = true;
  TimeOfDay _timedi = new TimeOfDay.now();
  TimeOfDay _timedt = new TimeOfDay.now();

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
  TextEditingController tectipo = new TextEditingController();
  TextEditingController tecpermissao = new TextEditingController();
  TextEditingController tecdataInicio = new TextEditingController();
  TextEditingController tecHoraInicio = new TextEditingController();
  TextEditingController tecdataTermino = new TextEditingController();
  TextEditingController tecHoraTermino = new TextEditingController();

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

  Future<Null> _selectDataInicio(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 1)),
        lastDate: new DateTime.now().add(new Duration(days: 365))
    );
    if(picked != null) setState(() => tecdataInicio.text = _parseDate(picked.toString()));
  }

  Future<Null> _selectHoraInicio(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _timedi,
    );
    if(picked != null && picked != _timedi) setState(() => tecHoraInicio.text = picked.format(context));
  }

  Future _selectDataTermino(BuildContext context) async {
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
    if(picked != null && picked != _timedt) setState(() => tecHoraTermino.text = picked.format(context));
  }


  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _iscadastro = (widget.usuarioautorizadorVO == null);

    // ============================================================================
    // inicializa os controladores de campos com os respectivos atributos
    // ============================================================================
    tectipo.text = _iscadastro ? '' : widget.usuarioautorizadorVO.tipo;
    tecpermissao.text = _iscadastro ? '' : widget.usuarioautorizadorVO.permissao;
    tecdataInicio.text = _iscadastro ? '' : widget.usuarioautorizadorVO.dataInicio.substring(0,10);
    tecHoraInicio.text = _iscadastro ? '' : widget.usuarioautorizadorVO.dataInicio.substring(11,16);
    tecdataTermino.text = _iscadastro ? '' : widget.usuarioautorizadorVO.dataTermino.substring(0,10);
    tecHoraTermino.text = _iscadastro ? '' : widget.usuarioautorizadorVO.dataTermino.substring(11,16);

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

    List<Widget> _lstCamposUsuarioAutorizador = [];

   DropdownButton _itemQualificacaoAutorizacao() => DropdownButton<String>(
      value: _valueTipo,
      isExpanded: true,
      onChanged: (value){
        setState(() {
         _valueTipo = value; 
        });
      },
      items: [
        DropdownMenuItem(
          value: "T",
          child: Text("Autorizado Temporariamente"),
        ),
        DropdownMenuItem(
          value: "P",
          child: Text("Autorizado Permanente"),
        ),
      ],
    );    

   DropdownButton _itemQualAutorizacao() => DropdownButton<String>(
      value: _valueQualAuto,
      isExpanded: true,
      onChanged: (value){
        setState(() {
         _valueQualAuto = value; 
        });
      },
      items: [
        DropdownMenuItem(
          value: "00",
          child: Text("Permissão para Carimbar"),
        ),
      ],
    );    

    // ============================================================================
    // Criação dos campos que irão permitir a entrada de dados
    // ============================================================================
    _lstCamposUsuarioAutorizador.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: _itemQualificacaoAutorizacao()
        )
    );

    _lstCamposUsuarioAutorizador.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: _itemQualAutorizacao()
        )
    );

    //_lstCamposUsuarioAutorizador.add(criarWidgetEntry(tec: tectipo, tit: TextInputType.text, label: "Tipo de autorização"));
    //_lstCamposUsuarioAutorizador.add(criarWidgetEntry(tec: tecpermissao, tit: TextInputType.text, label: "Qual autorização"));
    //_lstCamposUsuarioAutorizador.add(criarWidgetEntry(tec: tecdataInicio, tit: TextInputType.text, label: "Data Início"));
    //_lstCamposUsuarioAutorizador.add(criarWidgetEntry(tec: tecdataTermino, tit: TextInputType.text, label: "Data Término"));

    _lstCamposUsuarioAutorizador.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: (){_selectDataInicio(context);},
              controller: tecdataInicio,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Data de Início",
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

    _lstCamposUsuarioAutorizador.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: (){_selectHoraInicio(context);},
              controller: tecHoraInicio,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Hora de Início",
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


    _lstCamposUsuarioAutorizador.add(
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

    _lstCamposUsuarioAutorizador.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: (){_selectHoraTermino(context);},
              controller: tecHoraTermino,
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


    // ==================================================================================
    // Move os conteúdos dos controladores para um VO para enviar um Mapa JSON ao backend
    // ==================================================================================
    _lstCamposUsuarioAutorizador.add( 
      new CommomActionButton(titulo: _iscadastro ? 'Salvar' : 'Enviar Modificações', 
          onpressed: () async {
          UsuarioAutorizadorVOPost newPost = new UsuarioAutorizadorVOPost(
              tokenid: _token,
              id: widget.usuarioautorizadorVO.id == null ? "0": widget.usuarioautorizadorVO.id.toString(),
              id_usuario: widget.usuarioautorizadorVO.id_usuario == null ? "0": widget.usuarioautorizadorVO.id_usuario.toString(), 
              id_autorizador: widget.usuarioautorizadorVO.id_autorizador == null ? "0": widget.usuarioautorizadorVO.id_autorizador.toString(), 
              id_campanha: widget.usuarioautorizadorVO.id_campanha == null ? "0": widget.usuarioautorizadorVO.id_campanha.toString(), 
              tipo: _valueTipo, 
              permissao: _valueQualAuto, 
              dataInicio: tecdataInicio.text + " " + tecHoraInicio.text + ":00", 
              dataTermino: tecdataTermino.text + " " + tecHoraTermino.text + ":00", 
          );
          String _urlcrud = _iscadastro ? '${_urlControlador}appInserirUsuarioAutorizador.php' : '${_urlControlador}appAtualizarUsuarioAutorizador.php';
          print (_urlcrud);
          UsuarioAutorizadorVOPost p = await createPost('${_urlcrud}', body: newPost.toMap());
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
                children: _lstCamposUsuarioAutorizador
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
