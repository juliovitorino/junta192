import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:junta192/br/com/jcv/linker/classes/constantes/url.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/colors.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-outline-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/contente_heading.dart';
import '../upload/uploadImage.dart';
import '../storages/cacheSession.dart';
import '../style/text_styles.dart';
import '../style/asset.dart';

class AdsSupermercadoTypeOneUpload extends StatefulWidget {
  dynamic vopost;
  //String imgPath;

  bool isGetImagem;
  
  AdsSupermercadoTypeOneUpload({Key key, 
  @required this.vopost,
  //@required this.imgPath,
  this.isGetImagem=false}) : super(key: key);

  @override
  _AdsSupermercadoTypeOneUploadState createState() => _AdsSupermercadoTypeOneUploadState();
}

class _AdsSupermercadoTypeOneUploadState extends State<AdsSupermercadoTypeOneUpload> {
  Widget _image;
  Widget _imagepicker;
  Future<PickedFile> _file;
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

  getImage() {
    _file = chooseImage().then((onValue){
      final snackBar = SnackBar(content: Text('Sua imagem está sendo enviada para nosso servidor do Junta10. Na próxima carga ela já irá aparecer na sua campanha.'));
      Scaffold.of(context).showSnackBar(snackBar);      
      //print("widget.vopost['id'].toString() => "+widget.vopost['id'].toString());
      //print("url=>" + urlUploadImagemUsuarioPublicidade);
      UploadImage upload = UploadImage(widget.vopost['id'].toString(), File(onValue.path), _token, urlUploadImagemUsuarioPublicidade);

    });
  }

  @override
  Widget build(BuildContext context) {

    // Armazena predefinições da telado dispositivo
    Size size= MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    String strInteiro = widget.vopost['vlPromoMoeda'].substring(5,7).replaceAll(new RegExp(r','), '');

    Widget widImg = widget.vopost['url'] == imgSemImagem 
                    ? Image.asset(imgSemImagem, 
                      width: screenWidth * 0.9,
                      fit: BoxFit.cover,
                    ) 
                    : Image.network(widget.vopost['url'],
                    width: screenWidth * 0.9,
                    fit: BoxFit.cover,
                  );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
    // --- Titulo promocional
          Container(
            width: screenWidth * 0.9,
            child: Text(widget.vopost['titulo'], style: adsSupermercadoTituloTS, textAlign: TextAlign.center,),
          ),

    // --- Descrição
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            width: screenWidth * 0.9,
            child: Text(widget.vopost['descricao'], style: adsSupermercadoDescricaoTS, textAlign: TextAlign.center,),
          ),

    // --- Empilhamento da imagens com preços          
          Stack(
            children: <Widget>[
    // --- Imagem   
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: widget.isGetImagem
                  ? GestureDetector(
                    onLongPress: getImage,
                    child: widImg,
                  )
                  : widImg,
                ),
              ),
    // --- Icone de upload imagem para orientação do usuário
    // --- no canto inferior esquerdo
              Positioned(
                left: 5,
                bottom: 25,
                child: !widget.isGetImagem 
                  ? Container(height: 0, width: 0,)
                  : InkWell(
                  onTap: widget.isGetImagem ? getImage :(){},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white
                    ),
                    child: Icon(Icons.file_upload, size: 32,)
                  ),
                )
              ),
    // --- Botão posicionado sobreposicionando preço promocional sobre a imagem
              Positioned(
                bottom: 4,
                right: 5,
                child: InkWell(
                  onTap: (){},
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.white,

  // --- container circular englobando o preço total
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        gradient: appGradiente,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

  // --- Primeira parte do preço cotendo valor inteiro. ex: "24"    
                          Container(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CommonOutlineText(
                                  text: strInteiro,
                                  fontsize: 64,
                                  strokeWidth: 6,
                                  color1: Colors.black,
                                  color2: Colors.white,
                                ),
                                Text("Por:", 
                                  textAlign: TextAlign.left,
                                  style: adsSupermercadoPrecoPromocaoPorTS
                                ),
                                
                              ]
                            ),
                          ),
      
  // --- Segunda parte do preço cotendo centavos ",99"    
                      Container(
                            padding: const EdgeInsets.only(bottom: 45),
                            child: CommonOutlineText(
                              text: widget.vopost['vlPromoMoeda'].substring(widget.vopost['vlPromoMoeda'].length-3),
                              fontsize: 22,
                              strokeWidth: 3,
                              color1: Colors.black,
                              color2: Colors.white,
                            ),
                          ),     
                        ],
                      ),
                    ),
                  ),
                ),
              ),

    // --- Botão posicionado sobreposicionando símbolo da moeda sobre a o preço no canto inferior direito
              Positioned(
                bottom: 0,
                right: 0,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.transparent,

// --- container circular englobando o símbolo da moeda
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

// --- Primeira parte do preço cotendo símbolo da moeda. ex: "BRL$"    
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                          child: Text(widget.vopost['vlPromoMoeda'].substring(0,5), 
                            textAlign: TextAlign.center,
                            style: adsSupermercadoMoedaTS
                          ),
                        ),
    
                      ],
                    ),
                  ),
                ),
              ),

// --- Detalhe do preço original no canto superior esquerdo da marca do preço
              Positioned(
                top: 0,
                left: 0,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.transparent,

// --- container englobando o preço original
                  child: Container(
                    //height: 60,
                    //width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                      child: CommonOutlineText(text: widget.vopost['vlNormalMoeda'], 
                        fontsize: 18, 
                        strokeWidth: 4,
                        color1: Colors.blue[700],
                        color2: Colors.grey[300],),
                    ),
                  ),
                ),
              )              

            ],
          ),

    // --- Observação sobre a promoção
          CommonContentHeading(heading: "Observações", style: adsSupermercadoObsHeadingTS,),
          Container(
            width: screenWidth * 0.9,
            child: Text(widget.vopost['observacao'], 
              style: adsSupermercadoObsTS),
          ),

        ],
      ),
    );
    

  }
}
