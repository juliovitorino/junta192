import 'package:flutter/material.dart';

class LinkerDataItem extends StatelessWidget{

  // atributos que serão utilizados nos itens e serão fornecidos
  // no construtor
  IconData icon;
  String texto;

  // Construtor para inicializar os atributos da classe
  LinkerDataItem(this.icon, this.texto);
  

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: new Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: InkWell(
          splashColor: Colors.orangeAccent,
          child: Container(
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(icon),
                      ),
                      Expanded(
                        child: Text(texto, style: TextStyle(fontSize: 14.0),),
                      )

                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}