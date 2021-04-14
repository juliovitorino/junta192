import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaDetail.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

class CampanhaCancelar extends StatefulWidget {
  dynamic _cartaofull;

  CampanhaCancelar(this._cartaofull);

  @override
  _CampanhaCancelarState createState() => _CampanhaCancelarState();
}

class _CampanhaCancelarState extends State<CampanhaCancelar> {
  String _token;
  String _urlControlador;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }  

  Future<Map> _delCampanha(String id) async {
    String url='${_urlControlador}appCancelarCampanha.php?tokenid=${_token}&campid=${id}';
    http.Response response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }

  void _excluirCampanhaClick(BuildContext context){
    _delCampanha(widget._cartaofull['id']).then((retorno){
        Icon _icon = retorno['msgcode'] == 'MSG-0079' 
        ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
        : Icon(Icons.error, size: 120.0, color: Colors.red,);

        CommonShowDialogYesNo csdyn = CommonShowDialogYesNo(
              context: context,
              icon: _icon,
              msg: retorno['msgcodeString']
            );
        csdyn.showDialogYesNo().then((onValue){
          Navigator.pop(context);
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          new CampanhaDetail(widget._cartaofull),
          CommomActionButton(titulo: "Cancelar Campanha", onpressed:() async {
            CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
              context: context,
              icon: Icon(Icons.help_outline, size: 120.0, color: Colors.red,),
              msg: "Tem realmente certeza de CANCELAR a campanha?",
              textYes: "Sim",
              textNo: "Não",
            );

            retorno.showDialogYesNo().then((onValue){
                if(retorno.getChoice() == 'Y'){
                  _excluirCampanhaClick(context);
                }
              }
            );

          },)
        ],
      ),
    );
  }
}