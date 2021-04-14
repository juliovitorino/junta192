import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaComentariosPositivos.dart';


class CampanhaComentariosPage extends StatefulWidget {
  dynamic _cartaofull;
  bool isShowImage;

  CampanhaComentariosPage(this._cartaofull, {this.isShowImage=false});

  @override
  _CampanhaComentariosPageState createState() => _CampanhaComentariosPageState();
}


class _CampanhaComentariosPageState extends State<CampanhaComentariosPage> {
  String _titulo = "Comentários Positivos";

  List<Widget> _pages = [];

  Widget _body;

  @override
  void initState() {
    super.initState();
    _pages.add(new CampanhaComentariosPN(widget._cartaofull, isShowImage: widget.isShowImage));
    _pages.add(new CampanhaComentariosPN(widget._cartaofull, isPositivo: false,isShowImage: widget.isShowImage));
    _body = _pages[0];
    _titulo = 'Comentários';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("$_titulo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
        centerTitle: true,
        backgroundColor: Colors.amber,

      ),
      body: _body,
      bottomNavigationBar: new CurvedNavigationBar(
        index: 0,
        height: 65.0,
        items: <Widget>[
          Icon(Icons.mood, size: 30),
          Icon(Icons.mood_bad, size: 30),
        ],
        color: Colors.amberAccent,
        buttonBackgroundColor: Colors.amberAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _body = _pages[index];
            setState(() {
              if(index == 0){
                _titulo = "Comentários Positivos";
              } else {
                _titulo = "Comentários Negativos";
              }

            });
          });
        },
      ),
    );
  }
}