import 'package:flutter/material.dart';

class LinkerDataItemBottom extends StatelessWidget{

  // atributos que serão utilizados nos itens e serão fornecidos
  // no construtor
  IconData icon;
  String texto;
  Widget pageAction;
  Function funcaoAction;

  // Construtor para inicializar os atributos da classe
  LinkerDataItemBottom(this.icon, this.texto, {this.pageAction, this.funcaoAction});
  

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
      child: new Container(
        child: InkWell(
          splashColor: Colors.orangeAccent,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if(pageAction != null){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => pageAction),
                            );            
                        }
                        if(funcaoAction != null){
                          funcaoAction();
                        }

                      },
                      child: Icon(icon, size: 35.0,),
                    ),

                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(texto, style: TextStyle(
                            fontSize: 12.0
                        ),),
                    )

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}