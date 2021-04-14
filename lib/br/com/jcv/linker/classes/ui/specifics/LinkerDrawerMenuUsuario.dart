import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  //String _urlControlador;
  String _nomeusuario = '.';
  String _emailusuario = '.';
  String _urlfoto;

  @override
  void initState(){
//    print(CacheSession().getSession()['usuariodto'].toString());
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _nomeusuario = CacheSession().getSession()['usuariodto']['apelido'];
    _urlfoto = CacheSession().getSession()['usuariodto']['urlfoto'];
      setState(() {
       _nomeusuario = CacheSession().getSession()['usuariodto']['apelido'];
       _emailusuario = CacheSession().getSession()['usuariodto']['email'];
      });
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