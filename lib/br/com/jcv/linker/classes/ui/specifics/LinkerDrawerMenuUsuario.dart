import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/sobre.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/qrcode/common-get-qrcode.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariocashback/UsuarioCashbackPage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/functions/funcoesAjuda.dart';
import 'package:junta192/br/com/jcv/linker/classes/functions/funcoesLauncher.dart';

//import 'package:junta10/br/com/jcv/linker/classes/cartao/cartaoPageEntregaResgate.dart';
//import 'package:junta10/br/com/jcv/linker/classes/usuariocashback/UsuarioCashbackPage.dart';
//import 'package:junta10/br/com/jcv/linker/classes/usuariopublicidade/UsuarioFinalPublicidadePage.dart';
//import 'package:junta10/br/com/jcv/linker/classes/usuariopublicidade/UsuarioPublicidadePage.dart';

class  LinkerDrawerMenuUsuario extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;

  LinkerDrawerMenuUsuario({
    Key key, 
    @required this.session
  }) : super(key: key);

  @override
  _LinkerDrawerMenuUsuarioState createState() => _LinkerDrawerMenuUsuarioState();
}

class _LinkerDrawerMenuUsuarioState extends State<LinkerDrawerMenuUsuario> {
  String _token;
  String _nomeusuario = '.';
  String _emailusuario = '.';
  String _urlfoto;
  String _urlControlador;
  String qrcode;

  @override
  void initState(){
//    print(CacheSession().getSession()['usuariodto'].toString());
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _nomeusuario = CacheSession().getSession()['usuariodto']['apelido'];
    _urlfoto = CacheSession().getSession()['usuariodto']['urlfoto'];
      setState(() {
       _nomeusuario = CacheSession().getSession()['usuariodto']['apelido'];
       _emailusuario = CacheSession().getSession()['usuariodto']['email'];
      });
  }  

  Future<String> abrirPaginaCapturarQrCode(BuildContext context) async {
    final result = await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => new CommonGetQRCode() )
    );
    return result;
  } 


  Future<Map> _inserirRegistroIndicacao() async {
    http.Response response;
    String _url = '${_urlControlador}appInserirRegistroIndicacao.php?tokenid=$_token&tokenidui=$qrcode';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context){

        return new Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                      Colors.deepOrange,
                      Colors.orangeAccent
                  ])
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                          Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          QrImage(
                            data: _token,
                            size: 128,
                            gapless: true,
                            errorCorrectionLevel: QrErrorCorrectLevel.Q,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onDoubleTap: () {
                                  final String msg = 'Você está logado como ' + _nomeusuario;
                                  CommonShowDialogYesNo csd = new CommonShowDialogYesNo(msg: msg, icon: Icon(Icons.person, size: 128,), context: context,);
                                  csd.showDialogYesNo();
                                },
                                child: new CommonImageCircle(_urlfoto, widthcic: 128, heightcic: 128,),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                )
              ),
              new LinkerListTile(Icons.settings, 'Minhas Campanhas', ()=>{}, new CampanhaPage(session: new SessionStorage())),
              ////new LinkerListTile(Icons.watch_later, '24H de Promoções', ()=>{},new UsuarioFinalPublicidadePage()),
              new LinkerListTile(Icons.help, 'Como funciona?', ()=>fcnAcionarAjudaComoFunciona(context),null),
              new LinkerListTile(Icons.support_agent_outlined, 
                                'Suporte via WhatsApp', 
                                () async => fcnWhatsApp(
                                        GlobalStartup().getWhatsappSuporteNumero(),
                                        GlobalStartup().getwhatsappSuporteMsg()
                                ),
                                null),
              new LinkerListTile(Icons.share_outlined, 
                                "Compartilhe com Amigos", 
                                () async {
                                    final StringBuffer sb = new StringBuffer();
                                    sb.writeln("Olá essa é uma mensagem enviada pelo");
                                    sb.writeln("seu amigo *$_nomeusuario* que está te convidando para se juntar ao aplicativo *Junta10*");
                                    sb.writeln("e começar a *GANHAR VANTAGENS* no comércio da região.");
                                    sb.writeln(" ");
                                    sb.writeln("Para instalar no seu aparelho baixe pelo link abaixo:");
                                    sb.writeln(" ");
                                    sb.writeln("Android -> http://bit.ly/junta10");
                                    sb.writeln("iPhone -> http://bit.ly/junta10iOS");
                                    await Share.share( sb.toString(),
                                                      subject: "Compartilhe com amigos e clientes"
                                                     );
                                }, 
                                null),
              new LinkerListTile(const IconData(0xee49, fontFamily: 'MaterialIcons'), "Campanha de Indicação", () async {
                  qrcode =  await abrirPaginaCapturarQrCode(context);
                  print("*****************************");              
                  print("Qrcode capturado = $qrcode");              
                  print("*****************************");  
                  _inserirRegistroIndicacao().then((mapa){
                    final msg = mapa['msgcode'] == "MSG-0001"
                                ? "Sua indicação foi registrada com sucesso"
                                : mapa['msgcodeString'];
                    CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
                      context: context,
                      icon: Icon(Icons.info),
                      msg: msg,
                    )
                    ..showDialogYesNo();
                  }); 

              }, null), 
              new LinkerListTile(Icons.info_outline, "Sobre", ()=>{}, new Sobre()),
              //new LinkerListTile(Icons.group, 'Indique um amigo', ()=>{},null),
              //new LinkerListTile(Icons.person, 'Meu Perfil', ()=>{},null),
              //new LinkerListTile(Icons.pin_drop, 'Onde tem Junta10?', ()=>{},null),
              //new LinkerListTile(Icons.monetization_on, 'Gerenciar Cashback', ()=>{}, new UsuarioCashbackPage()),
              //new LinkerListTile(Icons.record_voice_over, 'Anunciar Promoções', ()=>{}, new UsuarioPublicidadePage()),
              //new LinkerListTile(Icons.casino, 'Sorteios', ()=>{}, new UsuarioPublicidadePage()),
              //new LinkerListTile(Icons.notifications, 'Notificações', ()=>{},null),
              //new LinkerListTile(Icons.settings, 'Preferências', ()=>{},null),
              new Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: new Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400))
                ),
                child: InkWell(
                  splashColor: Colors.orangeAccent,
                  onTap: (){
                    (new SessionStorage()).deleteSession();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                  height: 50.0,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Row(
                        children: <Widget>[
                            Icon(Icons.exit_to_app),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Sair", style: TextStyle(
                                fontSize: 16.0
                                ),
                              ),
                            )

                          ],
                        ),
                        Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
                ),
              )

        ],
      ),

    );
  }

}

class LinkerListTile extends StatelessWidget{

  // atributos que serão utilizados nos itens e serão fornecidos
  // no construtor
  IconData icon;
  String texto;
  Function onTap;
  Widget rota;

  // Construtor para inicializar os atributos da classe
  LinkerListTile(this.icon, this.texto, this.onTap, this.rota);
  

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: new Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: (){
            onTap();
            if(rota != null){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => rota),
              );
            }
          },
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(texto, style: TextStyle(
                            fontSize: 16.0
                        ),),
                    )

                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );

  }
}