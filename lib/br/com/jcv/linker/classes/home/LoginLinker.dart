import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/home/HomePage.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/NovaContaPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuParceiro.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuUsuario.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuAdmin.dart';


class LoginLinker extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  LoginLinker({
    Key key,
    this.primaryColor, this.backgroundColor, this.backgroundImage, @required this.session
  }) : super(key: key);

  @override
  _LoginLinkerState createState() => _LoginLinkerState();
}

class _LoginLinkerState extends State<LoginLinker> {
  bool _success;
  String _userID;

  TextEditingController _email = new TextEditingController();
  TextEditingController _pwd = new TextEditingController();
  Widget _statusLogin = new Container(width: 0, height: 0,);

  bool val = true;

  void _onSwitchValueChanged(value) {
    setState(() {
      val = value;
    });
  }

  // remover a chamada em produção código em pro
  void _randomNumber(){
    var _rnd = new Random();
    int _n = 120 + _rnd.nextInt(2892);
    setState(() {
      _email.text = _n.toString();
      _pwd.text = '1';
    });
  }

  void _onLoginPressedClick() {
    setState(() {
      _statusLogin = new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text("   Conectando ... ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
        ],
      );
    });
    // Realiza o login e espera o Future<Map>
    _realizarLogin()
    .then((mapa) {
      print(json.encode(mapa));
      if(mapa['msgcode'] == 'MSG-0001'){
        
        // grava a seção no dispositivo se o usuário quer manter a sessãoa ativa
        widget.session.writeSession(json.encode(mapa));

        // Grava o mapa da sessao dentro de um singleton
        CacheSession().setSession(json.encode(mapa));
        //debugPrint(json.encode(mapa));

        //  - login ok --- redireciona para a homepage correta de acordo com 
        // o perfil do usuário
        switch (mapa['tipousuario']) {
          case 'A': // admin menu drawer
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: new LinkerDrawerMenuAdmin()) ),
                  );
            break;
          case 'P': // parceiro menu drawer
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: new LinkerDrawerMenuParceiro(session: new SessionStorage())) ),
                  );
            break;

          default: // usuario comum menu drawer
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: new LinkerDrawerMenuUsuario(session: new SessionStorage())) ),
                  );
        }

      } else {
        setState(() {
          _statusLogin = new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error, color: Colors.redAccent,),
              Text(mapa['msgcodeString'], style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
            ],
          );
        });
      }
    })
    .catchError((onError) {});
  }

  Future<Map> _realizarLogin() async {
    http.Response response;

    // Obtem os valores dos controles na view
    String usernamepost = _email.text;
    String pwdpost = _pwd.text;
    String keeppost = val ? 'true' : 'false';
    String versao = GlobalStartup().getVersao();

    // Solicita a requisição na URL por enquanto sem callback
    String url = GlobalStartup().getGateway() + '/loginAppController.php?username=${usernamepost}&password=${pwdpost}&keep=${keeppost}&vrs=${versao}';
    debugPrint(url);
//    String url='http://elitefinanceira.com/cfdi/php/classes/gateway/loginAppController.php?username=${usernamepost}&password=${pwdpost}&keep=${keeppost}';
debugPrint("vou executar o backend");
    response = await http.get(Uri.parse(url));
debugPrint("vou devolver o retorno do backend");
    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(imgJunta10_1000x1000),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text("Junta10", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold,))
                    ],
                  ),
                ),
/*
                new ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: widget.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
                    child: GestureDetector(
                      onLongPress: _randomNumber,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Linker",
                            style: TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                color: widget.primaryColor),
                          ),
                          Text(
                            "Clube de Vantagens",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: widget.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
*/                
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
                          Icons.alternate_email,
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
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Digite seu email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                          Icons.lock_open,
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
                          controller: _pwd,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Digite sua senha',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Me mantenha conectado", 
                      style: TextStyle(color: Colors.grey),),
                      Switch(value: val, onChanged: (value){
                        _onSwitchValueChanged(value);
                      },)
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          splashColor: widget.primaryColor,
                          color: widget.primaryColor,
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "ENTRAR",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              new Expanded(
                                child: Container(),
                              ),
                              new Transform.translate(
                                offset: Offset(15.0, 0.0),
                                child: new Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: FlatButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(28.0)),
                                    splashColor: Colors.white,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: widget.primaryColor,
                                    ),
                                    onPressed: _onLoginPressedClick,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: _onLoginPressedClick,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _statusLogin,
                ),

                
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Você é novo aqui? Crie uma conta.",
                              style: TextStyle(color: widget.primaryColor),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new NovaContaPage(
                                  primaryColor: Color(0xFF4aa0d5),
                                  backgroundColor: Colors.white,
                                  backgroundImage: new AssetImage("assets/images/full-bloom.png"),
                                  session: new SessionStorage()
                              ) ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),


                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Esqueci minha senha",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                          onPressed: () => {},
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            )            
          ],
        ),
      
    ),
    );
  }
}



class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
