import 'dart:async';

import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/HomePage.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
//import 'package:junta192/br/com/jcv/linker/classes/home/HomePage.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/LoginPassaporte.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuAdmin.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuParceiro.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuUsuario.dart';
import '../style/asset.dart';

class LinkerSplashScreen extends StatefulWidget {
  
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  // Construtor alimentando instancia da sessão
  LinkerSplashScreen({Key key, @required this.session}) : super(key: key);

  @override
  _LinkerSplashScreenState createState() => _LinkerSplashScreenState();

}

class _LinkerSplashScreenState extends State<LinkerSplashScreen> {
  bool _isvisible = true;

  // Verifica se tem uma sessão em aberto pra evitar demora no login
  // Sempre o sid será validado internamente nos outros processos
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 10),(){
      setState(() {
        _isvisible = false;
      });
    });

    // Inicializa Cache do GlobalStartup
    GlobalStartup();

    // Verifica o arquivo da sessão
    widget.session.readSession().then((String value) {
      if (value == "no session"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new LoginPassaporte(session: new SessionStorage(),) ),
        );

      } else {
/*
quebra galho pra recriar a sessão interna no dispositivo
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new LoginPassaporte(session: new SessionStorage(),) ),
        );
*/   
        // Grava o mapa da sessao dentro de um singleton
        CacheSession().setSession(value);
        
        // Decide o Drawer de acordo com o tipo do usuário
        final Map sessao = CacheSession().getSession();
        print(sessao['tipousuario']);
        final Widget drawer = sessao['tipousuario'] == 'P' 
                              ? LinkerDrawerMenuParceiro(session: new SessionStorage()) 
                              : sessao['tipousuario'] == 'A'  
                              ? LinkerDrawerMenuAdmin()
                              : LinkerDrawerMenuUsuario(session: new SessionStorage()) ;


        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: drawer) ),
              );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent,)
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(imgJunta10_1000x1000),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text("Junta10", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold,))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: _isvisible 
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(padding: EdgeInsets.only(top: 20.0),),
                      Text("Carregando...", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold,))
                    ],
                  )
                : Container(width: 0, height: 0,),
              )
            ],
          )
        ],
      ),
      
    );
  }
}