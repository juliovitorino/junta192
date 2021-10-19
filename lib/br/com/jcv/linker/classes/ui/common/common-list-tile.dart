import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget{

  // atributos que serão utilizados nos itens e serão fornecidos
  // no construtor
  IconData icon;
  String texto;
  Function onTap;
  Widget rota;

  // Construtor para inicializar os atributos da classe
  CommonListTile(this.icon, this.texto, this.onTap, this.rota);
  

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