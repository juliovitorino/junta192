import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cashback/SaldoCashbackCCPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
//import 'package:junta10/br/com/jcv/linker/classes/ticket/DoarMeusCarimbos.dart';
import 'package:junta192/br/com/jcv/linker/classes/ticket/MeusCartoesFavoritos.dart';
import 'package:junta192/br/com/jcv/linker/classes/ticket/MeusCartoesPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ticket/ValidarTicketPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarionotificacao/UsuarioNotificacaoContainer.dart';


class HomePage extends StatefulWidget {

  final Widget drawerMenu;

 HomePage({
    Key key,
    this.drawerMenu
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  List<Widget> _pages = [
    new ValidarTicketPage(session: new SessionStorage()),
    new MeusCartoesDigitaisPage( session: new SessionStorage()),
    new MeusCartoesFavoritosPage(session: new SessionStorage()),
    new SaldoCashbackCCPage(),
    new UsuarioNotificacaoContainer() 
  ];

  //Widget _drawerMenuApp;
  Widget _body;
  String _titulo = "Carimbar Cartela";
  bool isMenuAtivo = false;

  @override
  void initState() {
    super.initState();
    //_getMenu();
    _body = _pages[0];
  }

/*
  void _getMenu(){
    SessionStorage _sess = new SessionStorage();
    _sess.readSession()
    .then((value) {
      var _su = json.decode(value);
      print(_su['tipousuario']);
      switch (_su['tipousuario']) {
        case 'A':
          setState(() {
            _drawerMenuApp = new LinkerDrawerMenuAdmin();
          });
          break;
        case 'P':
          setState(() {
            _drawerMenuApp = new LinkerDrawerMenuParceiro(session: new SessionStorage());
          });
          break;
        default:
          setState(() {
            _drawerMenuApp = new LinkerDrawerMenuUsuario(session: new SessionStorage());
          });
          
      }
    });

  }
*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Text("$_titulo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
        centerTitle: true,
        backgroundColor: Colors.amber,

      ),
      body: _body, 
      drawer: widget.drawerMenu,
      bottomNavigationBar: new CurvedNavigationBar(
        index: 0,
        height: 65.0,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.credit_card, size: 20),
          Icon(Icons.favorite, size: 20),
          Icon(Icons.monetization_on, size: 20),
          Icon(Icons.notifications_active, size: 20),
        ],
        color: Colors.amberAccent,
        buttonBackgroundColor: Colors.amberAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _body = _pages[index];
            switch(index){
              case 0:
                _titulo = "Carimbar Cartela";
                break;
              case 1:
                _titulo = "Meus Cartões";
                break;
              case 2:
                _titulo = "Favoritos";
                break;
              case 3:
                _titulo = "Meu CashBack";
                break;
              case 4:
                _titulo = "Notificações para mim";
                break;
              default:
                _titulo = "Carimbar Cartela";
            }
          });
        },
      ),
    );
  }
}