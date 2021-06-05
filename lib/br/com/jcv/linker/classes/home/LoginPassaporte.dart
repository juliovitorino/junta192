import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cache_session_apple_signin.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage_apple_signin.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/home/HomePage.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/login-facebook-post.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/LoginLinker.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDrawerMenuUsuario.dart';



Future<LoginFacebookPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return LoginFacebookPost.fromJson(json.decode(response.body));
  });
}

class LoginPassaporte extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  LoginPassaporte({
    Key key,
    @required this.session
  }) : super(key: key);

  @override
  _LoginPassaporteState createState() => _LoginPassaporteState();
}

class _LoginPassaporteState extends State<LoginPassaporte> {
  bool _success;
  String _userID;
  String _msg;
  bool isMsg = false;

  TextEditingController _email = new TextEditingController();
  TextEditingController _pwd = new TextEditingController();
  Widget _statusLogin = new Container(width: 0, height: 0,);

  bool val = true;

  bool isLoggedIn = false;
  var profileData;


  AuthorizationCredentialAppleID _appleCredential;
  var facebookLogin = FacebookLogin();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void _googleLogin() async{
    try {
print("==> 2");

      await _googleSignIn.signOut();
      await _googleSignIn.signIn();
print("Terminei _googleSignIn.signIn() ==> 2");
      setState(() {
        isLoggedIn = true;
      });
    } catch (e) {
      print(e);
    }
  }

  void _googleLogout() async{
      await _googleSignIn.signOut();
      setState(() {
        isLoggedIn = false;
      });
  }

//==========================================
// Obter as credenciais do provider da apple
//==========================================
  void _appleLogin() async {
    _appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
/*
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
            'jcv.com.br.junta10',
        redirectUri: Uri.parse(
          'https://elitefinanceira.com/producao/cfdi/php/classes/gateway/callbacks/sign_in_with_apple'
          ),
        ),
*/
    );

    print(_appleCredential);
  }





  void initiateFacebookLogin() async {
    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
                .accessToken.token}'));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);
        break;
    }
  }


  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  void _onSwitchValueChanged(value) {
    setState(() {
      val = value;
    });
  }

//=======================================
// Login atraves de provider Apple
//=======================================

  void _onLoginAppleClick() async {
      await _appleLogin();

      print("============================================");
      print("Retornou do _appleLogin()");
      print(_appleCredential);
      print("============================================");

      _realizarLoginApple().then((mapa){
          debugPrint(mapa.msgcode);
          debugPrint(json.encode(mapa.sessaodto));

          if(mapa.msgcode == "MSG-0135" || mapa.msgcode == "MSG-0136" || mapa.msgcode == "MSG-0138" || mapa.msgcode == "MSG-0134"){
            setState(() {
              _msg = mapa.msgcodeString;
              isMsg = true;
            });
            print(mapa.msgcodeString);
          } else {
            setState(() {
              _msg = "";
              isMsg = false;
            });

            // grava a seção no dispositivo se o usuário quer manter a sessãoa ativa
            widget.session.writeSession(json.encode(mapa.sessaodto));

            // ATENÇÃO: Grava uma sessão exclusiva da apple pra gerenciar o login SignIn With Apple conforme texto do forum apple ***
            // depois mantem um singleton pra acessar durante o 2o login em diante

            //This behaves correctly, user info is only sent in the ASAuthorizationAppleIDCredential upon initial user sign up. 
            //Subsequent logins to your app using Sign In with Apple with the same account do not share any user info and will only return a user identifier in the 
            //ASAuthorizationAppleIDCredential. It is recommened that you securely cache the initial ASAuthorizationAppleIDCredential containing the user info until 
            //you can validate that an account has succesfully been created on your server.
            final SessionStorageAppleSignIn _sessionAppleSignIn = SessionStorageAppleSignIn()
            ..writeSession(json.encode(mapa.sessaodto));

            // Grava o mapa da sessao dentro de um singleton
            CacheSession().setSession(json.encode(mapa.sessaodto));
            CacheSessionAppleSignIn().setSession(json.encode(mapa.sessaodto));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: new LinkerDrawerMenuUsuario(session: new SessionStorage())) ),
            );
          }

        });
  }

  

//=======================================
// Login atraves de provider google
//=======================================

  void _onLoginGoogleClick() async {
      await _googleLogin();

      print("============================================");
      print("Retornou do _googleLogin()");
      print(_googleSignIn.currentUser.displayName);
      print("============================================");

      _realizarLoginGoogle().then((mapa){
          debugPrint(mapa.msgcode);
          debugPrint(json.encode(mapa.sessaodto));

          if(mapa.msgcode == "MSG-0135" || mapa.msgcode == "MSG-0136" || mapa.msgcode == "MSG-0138" || mapa.msgcode == "MSG-0134"){
            setState(() {
              _msg = mapa.msgcodeString;
              isMsg = true;
            });
            print(mapa.msgcodeString);
          } else {
            setState(() {
              _msg = "";
              isMsg = false;
            });

            // grava a seção no dispositivo se o usuário quer manter a sessãoa ativa
            widget.session.writeSession(json.encode(mapa.sessaodto));

            // Grava o mapa da sessao dentro de um singleton
            CacheSession().setSession(json.encode(mapa.sessaodto));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: new LinkerDrawerMenuUsuario(session: new SessionStorage())) ),
            );
          }

        });
  }

//=======================================
// Login atraves de provider facebook
//=======================================

  void _onLoginFacebookClick() async {
      await initiateFacebookLogin();
      _realizarLoginFacebook().then((mapa) {
        debugPrint(mapa.msgcode);
        debugPrint(json.encode(mapa.sessaodto));
        if(mapa.msgcode == "MSG-0135" || mapa.msgcode == "MSG-0136" || mapa.msgcode == "MSG-0138" ){
          setState(() {
            _msg = mapa.msgcodeString;
            isMsg = true;
          });
          print(mapa.msgcodeString);
        } else {
          // grava a seção no dispositivo se o usuário quer manter a sessãoa ativa
          widget.session.writeSession(json.encode(mapa.sessaodto));

          // Grava o mapa da sessao dentro de um singleton
          CacheSession().setSession(json.encode(mapa.sessaodto));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new HomePage(drawerMenu: new LinkerDrawerMenuUsuario(session: new SessionStorage())) ),
          );
        }
      });

  }


//================================================
// Login atraves de provider proprio email e senha
//================================================

  void _onLoginEmailClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new LoginLinker(
          primaryColor: Color(0xFF4aa0d5),
          backgroundColor: Colors.white,
          backgroundImage: new AssetImage("assets/images/full-bloom.png"),
          session: new SessionStorage()
      ) ),
    );
  }

//================================================
// Realizar login apple no backend
//================================================

  Future<LoginFacebookPost> _realizarLoginApple() async {
    http.Response response;

    // se retorna nulo na givenName do SignIn Apple inicializa o cache Paralelo
    if(_appleCredential.givenName == null ){
      String sessionAppleSignIn = await SessionStorageAppleSignIn().readSession();
      CacheSessionAppleSignIn().setSession(sessionAppleSignIn);
    }

    // Obtem os valores dos controles na view
    String usernamepost = _appleCredential.givenName?? CacheSessionAppleSignIn().getSession()['usuariodto']['apelido'];
    String emailfcbk = _appleCredential.email?? CacheSessionAppleSignIn().getSession()['usuariodto']['email'];
    String keeppost = val ? 'true' : 'false';
    String idfcbk = _appleCredential.userIdentifier;
    String fotourl = "no-user.png" ;
    String versao = GlobalStartup().getVersao();

print('informações no metodo => _realizarLoginApple()');
print(usernamepost);
print(emailfcbk);
print(idfcbk);
print(fotourl);

    LoginFacebookPost newPost = new LoginFacebookPost(idfcbk,
        usernamepost,
        emailfcbk,
        fotourl,
        versao);
print("GatewaySSL ==>" + GlobalStartup().getGatewaySsl())        ;
print("Versao ==>" + GlobalStartup().getVersao())        ;
    LoginFacebookPost p = await createPost(GlobalStartup().getGatewaySsl() + '/appFacebookAutenticacao.php', body: newPost.toMap());
    return p;
  }




  Future<LoginFacebookPost> _realizarLoginGoogle() async {
    http.Response response;

    // Obtem os valores dos controles na view
    String usernamepost = _googleSignIn.currentUser.displayName;
    String emailfcbk = _googleSignIn.currentUser.email;
    String keeppost = val ? 'true' : 'false';
    String idfcbk = _googleSignIn.currentUser.id;
    String fotourl = _googleSignIn.currentUser.photoUrl == null ? "no-user.png" : _googleSignIn.currentUser.photoUrl ;
    String versao = GlobalStartup().getVersao();


print(usernamepost)    ;
print(emailfcbk);
print(idfcbk);
print(fotourl);

    LoginFacebookPost newPost = new LoginFacebookPost(idfcbk,
        usernamepost,
        emailfcbk,
        fotourl,
        versao);
print("GatewaySSL ==>" + GlobalStartup().getGatewaySsl())        ;
print("Versao ==>" + GlobalStartup().getVersao())        ;
    LoginFacebookPost p = await createPost(GlobalStartup().getGatewaySsl() + '/appFacebookAutenticacao.php', body: newPost.toMap());
    return p;
  }



  Future<LoginFacebookPost> _realizarLoginFacebook() async {
    http.Response response;

    // Obtem os valores dos controles na view
    String usernamepost = profileData['name'];
    String emailfcbk = profileData['email'];
    String keeppost = val ? 'true' : 'false';
    String idfcbk = profileData['id'];
    String fotourl = profileData['picture']['data']['url'];
    String versao = GlobalStartup().getVersao();

print("GatewaySSL ==>" + GlobalStartup().getGatewaySsl())        ;
print("Versao ==>" + GlobalStartup().getVersao())        ;

    LoginFacebookPost newPost = new LoginFacebookPost(idfcbk,
        usernamepost,
        emailfcbk,
        fotourl,
        versao);
    LoginFacebookPost p = await createPost(GlobalStartup().getGatewaySsl() + '/appFacebookAutenticacao.php', body: newPost.toMap());
//    LoginFacebookPost p = await createPost('http://elitefinanceira.com/cfdi/php/classes/gateway/appFacebookAutenticacao.php', body: newPost.toMap());
    return p;
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.asset(imgJunta10_1000x1000),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Junta10", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold,)),
                        Text("Plataforma de Fidelidade", style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,)),
                        Text("Campanhas e Recompensas", style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,)),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),

                //-------------------------------------------------
                // Entrar usando email/senha modificação 22.03.2021
                //-------------------------------------------------
/* Release Build Scrum 1.3 - Somente Usuário Comum 

                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          splashColor: Color(0xFF4aa0d5),
                          color: Color(0xFF4aa0d5),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "ENTRAR COM EMAIL",
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
                                      color: Colors.black87,
                                    ),
                                    onPressed: _onLoginEmailClick,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: _onLoginEmailClick,
                        ),
                      ),
                    ],
                  ),
                ),
*/
                //-------------------------------------------------
                // Entrar usando facebook modificação 22.03.2021
                //-------------------------------------------------
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          splashColor: Color(0xFF3B5998),
                          color: Color(0xff3B5998),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: AutoSizeText(
                                  "Continuar com Facebook",
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
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
                                      const IconData(0xea90, fontFamily: 'icomoon'),
                                      color: Color(0xff3b5998)),
                                    onPressed: _onLoginFacebookClick,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: _onLoginFacebookClick,
                        ),
                      ),
                    ],
                  ),
                ),


                //-------------------------------------------------
                // Entrar usando google modificação 22.03.2021
                //-------------------------------------------------
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          splashColor: Color(0Xffdb3236),
                          color: Color(0Xffdb3236),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: AutoSizeText(
                                  "Continuar com Google",
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
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
                                      const IconData(0xea88, fontFamily: 'icomoon'),
                                      color: Color(0Xffdb3236)),
                                    onPressed: _onLoginGoogleClick,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: _onLoginGoogleClick,
                        ),
                      ),
                    ],
                  ),
                ),
                //-------------------------------------------------
                // Entrar usando apple modificação 03.06.2021
                //-------------------------------------------------
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          splashColor: Color(0Xff000000),
                          color: Color(0Xff000000),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: AutoSizeText(
                                  "Continuar com Apple",
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
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
                                      const IconData(0xf8ff, fontFamily: 'icomoon'),
                                      color: Color(0Xff000000)),
                                    onPressed: _onLoginAppleClick,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: _onLoginAppleClick,
                        ),
                      ),
                    ],
                  ),
                ),



/* PODE APAGAR ESSE TRECHO DE CÓDIGO
                //---------------------------------
                // Entrar usando Login do Google
                //---------------------------------
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                            splashColor: Color(0Xffdb3236),
                            color: Color(0Xffdb3236),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "ENTRAR COM GOOGLE",
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
                                      const IconData(0xea88, fontFamily: 'icomoon'),
                                      color: Color(0Xffdb3236)),
                                    onPressed: null //_onLoginGoogleClick
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: null //_onLoginGoogleClick
                        ),
                      ),
                    ],
                  ),
                ),
*/
                isMsg 
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(_msg, style: TextStyle(backgroundColor: Colors.red, color: Colors.white)),
                  )
                : Container(width: 0, height: 0),
              ],
            )            
          ],
        ),
      
    ),
    );
  }
}
