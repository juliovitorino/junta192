import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuariopublicidade/ads-supermercado-typeone-upload.dart';


class UsuarioPublicidadeShowPage extends StatefulWidget {

  dynamic vopost;
  UsuarioPublicidadeShowPage(this.vopost);

  @override
  _UsuarioPublicidadeShowPageState createState() => _UsuarioPublicidadeShowPageState();
}

class _UsuarioPublicidadeShowPageState extends State<UsuarioPublicidadeShowPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Preview Promoção"),
      ),

      body: AdsSupermercadoTypeOneUpload(vopost: widget.vopost, isGetImagem: true),
    );
  }
}
