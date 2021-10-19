import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/plano/PlanoDetail.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';

class PlanoPage extends StatelessWidget {

  final Map planoPerfil;
  const PlanoPage(this.planoPerfil, { Key key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Plano", style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 10),
            child:  Column(
              children: <Widget>[
                  PlanoDetail(this.planoPerfil),
                  
                  // Botões de ação da page
                  Container(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", ()=>{},),
                        CommonFlatButtonFunction(Icon(Icons.delete, color: Colors.white), "Apagar", ()=>{}, color: Colors.red[600],),
                      ],
                    ),
                  ),    

              ],
            ),
          )
      ); 
  }


}

