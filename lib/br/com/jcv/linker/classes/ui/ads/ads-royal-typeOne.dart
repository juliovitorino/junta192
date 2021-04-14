import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:junta192/br/com/jcv/linker/classes/constantes/url.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/upload/uploadImage.dart';

class AdsRoyalTypeOne extends StatefulWidget {
  String id;
  Color corFundo;
  Color corFundoTitulo;
  Color corFundoRodape;
  Color corBorda;
  Color corBordaTitulo;
  Color corBordaRodape;
  String urlImgPrincipal;
  String titulo;
  bool isGetImagem;
  Widget rodape;
  
  AdsRoyalTypeOne(this.id, this.urlImgPrincipal, this.titulo, this.rodape,
  {Key key, Color this.corFundo, this.corBorda, this.corBordaTitulo, 
    this.corFundoTitulo, this.corFundoRodape, this.corBordaRodape, this.isGetImagem=false}) : super(key: key);

  @override
  _AdsRoyalTypeOneState createState() => _AdsRoyalTypeOneState();
}

class _AdsRoyalTypeOneState extends State<AdsRoyalTypeOne> {
  Widget _image;
  Widget _imagepicker;
  Future<File> _file;
  String _token;
  String _urlControlador;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";

  }  

  Future<PickedFile> chooseImage() {
    ImagePicker _picker = ImagePicker();
    return _picker.getImage(source: ImageSource.gallery);
  }
/* substituida 24.03.2021
  Future<File> chooseImage() {
    return ImagePicker.pickImage(source: ImageSource.gallery);
  }
*/

  getImage(){
    _file = chooseImage().then((onValue){
      final snackBar = SnackBar(content: Text('Sua imagem está sendo enviada para nosso servidor do Junta10. Na próxima carga ela já irá aparecer na sua campanha.'));
      Scaffold.of(context).showSnackBar(snackBar);      
      UploadImage upload = UploadImage(widget.id, File(onValue.path), _token, urlUploadImagemCampanha);

    });
  }

  @override
  Widget build(BuildContext context) {

    _image = Image.network(widget.urlImgPrincipal);
    _imagepicker = widget.isGetImagem 
    ? GestureDetector(
        onLongPress: (){
          getImage();
        },
        child: ClipRRect(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
          child: _image,
        )
      )
    : ClipRRect(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
        child: Image.network(widget.urlImgPrincipal),
      );

    return new Container(
          color: Colors.transparent,
          child: new Container(
              decoration: new BoxDecoration(
                  border: new Border.all(width: 1.0, color: widget.corBorda == null ? Colors.black38: widget.corBorda),
                  color: widget.corFundo == null ? Colors.transparent : widget.corFundo,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0),
                      )
                      
                  ),
              child: Column(
                children: <Widget>[
                  _imagepicker,
                  Container(
                    height: 50.0,
                    decoration: new BoxDecoration(
                        border: new Border.all(color: widget.corBordaTitulo == null ? Colors.transparent : widget.corBordaTitulo),
                        color: widget.corFundoTitulo == null ? Colors.yellow : widget.corFundoTitulo,
                      ),                    
                    child: new Center(child: Text(widget.titulo, style: TextStyle(fontSize: 16.0)))
                  ),
                  Container(
                    height: 50.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                        ),
                        border: new Border.all(color: widget.corBordaRodape == null ? Colors.transparent : widget.corBordaRodape),
                        color: widget.corFundoRodape == null ? Colors.red : widget.corFundoRodape,
                      ),                    
                    child: new Center(child: widget.rodape)
                  )

                ],
              )
          ),
        );
  }
}