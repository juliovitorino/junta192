import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/plano/PlanoPageLV.dart';
import 'package:junta192/br/com/jcv/linker/classes/planousuario/plano-usuario-detail.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-pageroute.dart';

class PlanoUsuarioPage extends StatelessWidget {

  final Map planousuarioPerfil;
  const PlanoUsuarioPage(this.planousuarioPerfil, { Key key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Meu Plano", style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 10),
            child:  Column(
              children: <Widget>[
                  PlanoUsuarioDetail(this.planousuarioPerfil),
                  
                  // Botões de ação da page
                  Container(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //CommonFlatButtonPageRoute(Icon(Icons.edit, color: Colors.white), "Migrar Plano", new PlanoPageLV(),),
                        //CommonFlatButtonFunction(Icon(Icons.delete, color: Colors.white), "Apagar", ()=>{}, color: Colors.red[600],),
                      ],
                    ),
                  ),    

              ],
            ),
          )
      ); 
  }


}