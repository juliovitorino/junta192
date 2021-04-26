import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/LoginLinker.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/sobre.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';

class LinkerDrawerMenuAdmin extends StatelessWidget
{
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
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.link,size: 50.0,)
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Linker Admin', style: TextStyle(color: Colors.white, fontSize: 25.0)),
                      )
                    ],
                  ),
                )
              ),
              new LinkerListTile(Icons.settings, 'Preferências', ()=>{},null),
              new LinkerListTile(Icons.info_outline, "Sobre", ()=>{}, new Sobre()),
              new LinkerListTile(Icons.exit_to_app
                , 'Sair'
                , ()=>(new SessionStorage()).deleteSession()
                ,new LoginLinker(
                    primaryColor: Color(0xFF4aa0d5),
                    backgroundColor: Colors.white,
                    backgroundImage: new AssetImage("assets/images/full-bloom.png"),
                    session: new SessionStorage()
                  ) ),
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => rota),
              );            
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