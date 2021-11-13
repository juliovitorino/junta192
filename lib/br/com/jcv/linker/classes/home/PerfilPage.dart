import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/privacy-policy-page.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/sobre.dart';
import 'package:junta192/br/com/jcv/linker/classes/planousuario/plano-usuario-page.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-list-tile.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuario/usuarioPage.dart';


class PerfilPage extends StatefulWidget {

  PerfilPage({
    Key key,
  }) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}


class _PerfilPageState extends State<PerfilPage> {

  String _token;
  String _urlControlador;
  dynamic _perfil;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }  

  Future<Map> _getPerfilUsuarioCompleto() async {
    String url='${_urlControlador}appPesquisarPerfilUsuario.php?tokenid=$_token';
    http.Response response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Text("Sobre", style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.amber,

      ),
      body: 
          new FutureBuilder<Map>(
              future: _getPerfilUsuarioCompleto(),
              // ignore: missing_return
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
                debugPrint("Voltei do future");
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return new CommonLoading();
                  case ConnectionState.done:
                    if(snapshot.hasError) {
                      debugPrint("erro" + snapshot.error.toString());
                      return new CommonLoading();
                    }
                    if(snapshot.hasData){
                      debugPrint(jsonEncode(snapshot.data));
                      _perfil = snapshot.data;
                      return Container(
                        child: ListView(
                          children: <Widget>[
                              new CommonListTile(Icons.account_box, 'Meus Dados', ()=>{}, new UsuarioPage(_perfil['usuario'],_perfil['usuarioComplemento'])),
                              new CommonListTile(Icons.apps, 'Aplicativo', ()=>{}, new Sobre()),
                              new CommonListTile(Icons.account_balance_wallet, 'Meu Plano', ()=>{}, new PlanoUsuarioPage(_perfil['usuarioPlanoAtivo'])),
                              new CommonListTile(Icons.privacy_tip, 'Política de Privacidade', ()=>{}, new PrivacyPolycePage()),
                              //new CommonListTile(Icons.attach_money, 'Configuração de Cashback', ()=>{}, null),

                          ],
                        )
                      ); 
                    }
                    break;
                  default:
                    return new Container(
                      height: 0.0,
                      width: 0.0,
                    );
                }
              }
          ),      
      
      

    );
  }
}