import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/planousuario/plano-usuario-detail.dart';

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
      body: Container(
        padding: EdgeInsets.only(left: 8.0),
        child: PlanoUsuarioDetail(this.planousuarioPerfil),
      )
      
    );
    
  }
}