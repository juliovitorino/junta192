import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuario/usuario-detail.dart';

class UsuarioPage extends StatelessWidget {

  final Map usuarioPerfil;
  final Map usuarioComplemento;
  const UsuarioPage(this.usuarioPerfil, this.usuarioComplemento, { Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Meus Dados", style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 10),
            child:  Column(
              children: <Widget>[
                  SizedBox(height: 10,),
                  UsuarioDetail(this.usuarioPerfil, this.usuarioComplemento),
                  
                  // Botões de ação da page
                  Container(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", ()=>{},),
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