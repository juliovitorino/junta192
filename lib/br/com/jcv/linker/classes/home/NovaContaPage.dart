import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/home/NovaContaPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<NovaContaPost> createPost(String url, {Map body}) async {
print("createPost() =>" + url)  ;
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return NovaContaPost.fromJson(json.decode(response.body));
  });
}

class NovaContaPage extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  NovaContaPage({
    Key key,
    this.primaryColor,
    this.backgroundColor,
    this.backgroundImage,
    @required this.session
  }) : super(key: key);

  @override
  _NovaContaPageState createState() => _NovaContaPageState();
}

class _NovaContaPageState extends State<NovaContaPage> {

  TextEditingController _email = new TextEditingController();
  TextEditingController _apelido = new TextEditingController();
  TextEditingController _pwd = new TextEditingController();
  TextEditingController _pwd2 = new TextEditingController();
  Widget _statusLogin = new Container(width: 0, height: 0,);


  // remover a chamada em produção código em pro
  void _randomNumber(){
    var _rnd = new Random();
    int _n = 120 + _rnd.nextInt(2892);
    setState(() {
      _email.text = _n.toString() + "@jcv";
      _apelido.text = _n.toString() + "jcv";
      _pwd.text = '1';
      _pwd2.text = '1';
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
      if(mapa['msgcode'] == 'MSG-0001'){

        // envia a msg da pendência de atividação do email
        Navigator.of(context).pop;

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

    // Solicita a requisição na URL por enquanto sem callback
//    String url='http://elitefinanceira.com/cfdi/php/classes/gateway/loginAppController.php?username=${usernamepost}&password=${pwdpost}';
    String url = GlobalStartup().getGateway() +  '/loginAppController.php?username=${usernamepost}&password=${pwdpost}';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
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
                      Text("Criar Nova Conta", style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold,))
                    ],
                  ),
                ),                
/*                
                GestureDetector(
                  onLongPress: _randomNumber,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text(
                        "Junta10",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: widget.primaryColor),
                      ),
                      Text(
                        "Cashback, campanhas e recompensas",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: widget.primaryColor),
                      ),
                    ],
                  ),
                ),
*/
                //------------- ** Digite seu email ** -----------------
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

                //------------- ** Digite seu nome ** -----------------
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
                          controller: _apelido,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Digite seu nome',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //------------- ** Digite sua senha ** -----------------
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

                //------------- ** Confirmar senha ** -----------------
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
                          Icons.check,
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
                          controller: _pwd2,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirmar sua senha',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //------------- ** Botão Registrar ** -----------------
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
                                  "REGISTRAR",
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
                          onPressed: () async {
                            NovaContaPost newPost = new NovaContaPost(
                                email: _email.text,
                                username: _apelido.text,
                                passwd: _pwd.text,
                                passwd2: _pwd2.text,
                                cupom: "1");
 print("URL=>" + GlobalStartup().getGateway() + '/appNovaConta.php');
                            NovaContaPost p = await createPost(GlobalStartup().getGatewaySsl() + '/appNovaConta.php', body: newPost.toMap());
//                            NovaContaPost p = await createPost('http://elitefinanceira.com/cfdi/php/classes/gateway/appNovaConta.php', body: newPost.toMap());
                            Icon _icon = p.msgcode == 'MSG-0001'
                                ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
                                : Icon(Icons.error, size: 120.0, color: Colors.red,);

                            if(p.msgcode == 'MSG-0001'){
                              CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
                                context: context,
                                icon: _icon,
                                msg: "Sua conta " + _email.text + " foi criada com sucesso. Enviamos um email pedindo confirmação. Verifique seu email.",
                              );

                              retorno.showDialogYesNo().then((onValue){
                                  if(retorno.getChoice() == 'Y'){
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

                              retorno.showDialogYesNo().then((onValue){
                                  if(retorno.getChoice() == 'Y'){
                                    Navigator.pop(context);
                                  }
                                }
                              );
                            }

                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _statusLogin,
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
