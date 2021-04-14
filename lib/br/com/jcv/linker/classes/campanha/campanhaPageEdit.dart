import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPostFlash.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CampanhaFlashPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
print(response.body)    ;
    return CampanhaFlashPost.fromJson(json.decode(response.body));
  });
}

class CampanhaPageEdit extends StatefulWidget {

  dynamic campanhafull;

  CampanhaPageEdit(this.campanhafull);

  @override
  _CampanhaPageEditState createState() => _CampanhaPageEditState();
}

class _CampanhaPageEditState extends State<CampanhaPageEdit> {

  int _value;
  String _token;
  String _urlControlador;
  TextEditingController tecNome = new TextEditingController();
  TextEditingController tecRegras = new TextEditingController();
  TextEditingController tecDataInicio = new TextEditingController();
  TextEditingController tecDataTermino = new TextEditingController();
  TextEditingController tecRecompensa = new TextEditingController();
  TextEditingController tecFraseEfeito = new TextEditingController();
  TextEditingController tecFraseAgradecimento = new TextEditingController();
  TextEditingController tecValorTicket = new TextEditingController();

  String _parseDate(String strDate) {
    //           1
    // 0123456789012345678
    // 03-08-2019 11:59:15
    // 2019-09-03 11:78:87.3642864
    return strDate.substring(8,10) +
    "-" +
    strDate.substring(5,7) +
    "-" +
    strDate.substring(0,4) +
    " " +
    strDate.substring(11,19);

  }

  Future _selectDataInicio() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 1)),
        lastDate: new DateTime.now().add(new Duration(days: 365))
    );
    if(picked != null) setState(() => tecDataInicio.text = _parseDate(picked.toString()));
  }

  Future _selectDataTermino() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 1)),
        lastDate: new DateTime.now().add(new Duration(days: 365))
    );
    if(picked != null) setState(() => tecDataTermino.text = _parseDate(picked.toString()));
  }

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    tecNome.text = widget.campanhafull['nome'];
    tecRegras.text = widget.campanhafull['textoExplicativo'];
    tecRecompensa.text = widget.campanhafull['recompensa'];
    tecDataInicio.text = widget.campanhafull['dataInicio'];
    tecDataTermino.text = widget.campanhafull['dataTermino'];
    tecFraseEfeito.text = widget.campanhafull['fraseEfeito'];
    tecFraseAgradecimento.text = widget.campanhafull['msgAgradecimento'];
    tecValorTicket.text = widget.campanhafull['valorTicketMedioCarimbo'].toString();
    setState(() {
      _value = widget.campanhafull['maximoSelos'];
    });
  }

  @override
  Widget build(BuildContext context) {

    DropdownButton _itemMaxCarimbos() => DropdownButton<int>(
      value: _value,
      isExpanded: true,
      onChanged: (value){
        setState(() {
         _value = value; 
        });
      },
      items: [
        DropdownMenuItem(
          value: 5,
          child: Text("5 Selos"),
        ),
        DropdownMenuItem(
          value: 10,
          child: Text("10 Selos (padrão)"),
        ),
        DropdownMenuItem(
          value: 12,
          child: Text("12 Selos"),
        ),
        DropdownMenuItem(
          value: 15,
          child: Text("15 Selos"),
        ),
        DropdownMenuItem(
          value: 20,
          child: Text("20 Selos"),
        ),
      ],
    );

    List<Widget> _lstCamposCampanha = [];
    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              controller: tecNome,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Digite o nome da campanha",
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

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: _selectDataInicio,
              controller: tecDataInicio,
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
    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: _selectDataTermino,
              controller: tecDataTermino,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Data de Término Previsto",
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

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: _itemMaxCarimbos()
        )
    );

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              maxLines: 2,
              controller: tecRecompensa,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Qual é a recompensa dessa campanha",
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

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              controller: tecFraseAgradecimento,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Frase de agradecimento no recebimento da recompensa",
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

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              controller: tecFraseEfeito,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: "Frase de efeito da campanha",
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

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              controller: tecValorTicket,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                    labelText: "Valor do ticket médio",
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

    _lstCamposCampanha.add(
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              maxLines: 10,
              controller: tecRegras,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                    labelText: "Regras da campanha detalhada",
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

    _lstCamposCampanha.add( 
      new CommomActionButton(titulo: "Enviar Modificações", 
          onpressed: () async {
          CampanhaFlashPost newPost = new CampanhaFlashPost(
              tokenid: _token,
              idcamp: widget.campanhafull['id'],
              nome: tecNome.text, 
              regras: tecRegras.text,
              dataInicio: tecDataInicio.text,
              dataTermino: tecDataTermino.text,
              limMaxSelos: _value.toString(),
              recompensa: tecRecompensa.text,
              fraseAgradecimento: tecFraseAgradecimento.text,
              fraseEfeito: tecFraseEfeito.text,
              vlticket: tecValorTicket.text
          );
print("URL ==> " + _urlControlador)          ;
          CampanhaFlashPost p = await createPost('${_urlControlador}appAtualizarDadosCampanha.php', body: newPost.toMap());
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
                children: _lstCamposCampanha
              ),
            ),
            

          ],
        ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Editar Campanha"),
      ),
      body: _sceditview,
    );
  }
}