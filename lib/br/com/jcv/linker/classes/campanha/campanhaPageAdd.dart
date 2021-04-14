import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPostFlash.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

//enum Answers{YES, NO}

Future<CampanhaFlashPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CampanhaFlashPost.fromJson(json.decode(response.body));
  });
}
class CampanhaPageAdd extends StatefulWidget {
  @override
  _CampanhaPageAddState createState() => _CampanhaPageAddState();
}

class _CampanhaPageAddState extends State<CampanhaPageAdd> {
  String _token;
  String _urlControlador;
  TextEditingController nomeControler = new TextEditingController();
  TextEditingController recompensaControler = new TextEditingController();
  bool _showbtn = true;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";

  }  

  @override
  Widget build(BuildContext context) {

    Widget _btnAction = new CommomActionButton(titulo: "Criar Campanha", 
                      onpressed: () async {
                      CommonShowDialogYesNo csd = new CommonShowDialogYesNo(
                        icon: Icon(Icons.build, size: 128), 
                        msg: "Sua campanha foi enviada para criação. Aguarde ..." ,
                        context: context,);
                      csd.showDialogYesNo();
                      setState(() {
                        _showbtn = false; 
                      });
                      CampanhaFlashPost newPost = new CampanhaFlashPost(
                          tokenid: _token,
                          nome: nomeControler.text, 
                          recompensa: recompensaControler.text);
                      CampanhaFlashPost p = await createPost('${_urlControlador}appInserirCampanhaFlash.php', body: newPost.toMap());
                      Icon _icon = p.msgcode == 'MSG-0001' 
                      ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
                      : Icon(Icons.error, size: 120.0, color: Colors.red,);

                      if(p.msgcode == 'MSG-0001'){
                        CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
                          context: context,
                          icon: _icon,
                          msg: "Clique no botão 'Editar' para configurar os detalhes da sua campanha",
                        );

                        retorno.showDialogYesNo().then((onValue){
                            if(retorno.getChoice() == 'Y'){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          }
                        );

                      } else {

                        CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
                          context: context,
                          icon: _icon,
                          msg: p.msgcodeString,
                        );

                        retorno.showDialogYesNo();
                        setState(() {
                          _showbtn = true; 
                        });

                      }
                    });

    return Scaffold(
          appBar: AppBar(
            title: Text('Criar nova campanha'),
          ),
          body: new SingleChildScrollView(
            child: new Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: new Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        new Expanded(
                          child: TextField(
                            controller: nomeControler,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Digite o nome da sua campanha',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  new TextField(
                    maxLines: 4,
                    controller: recompensaControler,
                    decoration: InputDecoration(
                        hintText: "recompensa....", labelText: 'Recompensa'),
                  ),
                  _showbtn ? _btnAction : Container(height: 0, width: 0),
                ],
              ),
            ),
          )
    );
  }
}