import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaItem.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPageAdd.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoPageEntregaResgate.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';

class CampanhaPage extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  CampanhaPage({
    Key key, 
    @required this.session
  }) : super(key: key);

  @override
  _CampanhaPageState createState() => _CampanhaPageState();
}


class _CampanhaPageState extends State<CampanhaPage> {
  String _token;
  String _urlControlador;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }  

  Future<List> _getCampanhas() async {
    String url='${_urlControlador}appListarCampanhasUsuario.php?tokenid=$_token';
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Widget _body = new Column(
      children: <Widget>[

        CommomActionButton(
          color: Colors.blue,
          titulo: "Entregar Recompensa", 
          onpressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                  new CartaoPageEntregaResgate(session: new SessionStorage())),
                );            
            }
        ),
        SizedBox(height: 5,),
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: new FutureBuilder(
            future: _getCampanhas(),
            builder: (BuildContext conext, AsyncSnapshot<List> snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return new CommonLoading();
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return new CommonLoading();
                  case ConnectionState.done:
                    if(snapshot.hasError) {
                      return new CommonLoading();
                    }
                    if(snapshot.hasData){
                      return CampanhaItem(snapshot.data);
                    }
                    break;
                  default:
                  return new Container(
                    height: 0.0,
                    width: 0.0,
                  );
                }          
            },
          ), 
        ),

      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4C3),
      appBar: new AppBar(
        title: AutoSizeText("Gerenciador de Campanha", 
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                maxLines: 1,
                ),
        centerTitle: true,
        backgroundColor: Colors.amber,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new CampanhaPageAdd() ),
          );

        },
        child: Icon(Icons.add_circle, size: 35.0),
      ),
      body: _body
    );
    
  }
}