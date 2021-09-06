import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuario/usuario-detail.dart';

class UsuarioPage extends StatelessWidget {

  final Map usuarioPerfil;
  const UsuarioPage(this.usuarioPerfil, { Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Meus Dados", style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: UsuarioDetail(this.usuarioPerfil),
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", ()=>{},),
                  CommonFlatButtonFunction(Icon(Icons.delete, color: Colors.white), "Apagar", ()=>{}, color: Colors.red[600],),
                ],
              ),
            )
            ,
            

        ],
      ),
      
      
    );
    
  }
}