import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/admob/admob-custom.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'dart:async';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:share/share.dart';

class GetCarimboLivrePage extends StatefulWidget {
  // Cria uma SessionStorage pra verifica arquivo de sessão de login
  final SessionStorage session;
  final int idcampanha;

  GetCarimboLivrePage({
    Key key, 
    @required this.session,
    @required this.idcampanha
  }) : super(key: key);

  @override
  _GetCarimboLivrePageState createState() => _GetCarimboLivrePageState();
}

class _GetCarimboLivrePageState extends State<GetCarimboLivrePage> {
  final _statusLoading = new CommonLoading();
  String _carimbonovo = 'QR Code';
  bool _checking = false;
  String _token;
  String _urlControlador;
  AdMobCustomFactory<BannerAd> _bannerAd = AdMobCustomFactory('BannerAd');

@override
void initState(){
    super.initState();
  _token = CacheSession().getSession()['tokenid'];
  _urlControlador = GlobalStartup().getGateway() + "/";

  MobileAds.instance.initialize().then((status) {

      print("inicialização do AdMob feita: ${status.adapterStatuses}");

    }
  );

}  

void _carimboClick(BuildContext context){
  setState(() {
      _checking = true;
  });

  _getProximoCarimboLivre().then((mapa) {
      setState(() {
        _carimbonovo = mapa['carimbo'];
        _checking = false;
        if(mapa['msgcode'] == 'MSG-0054'){
          CommonShowDialogYesNo csdyn = new CommonShowDialogYesNo(
            context: context,
            icon: new Icon(Icons.error, size: 120.0, color: Colors.red),
            msg: mapa['msgcodeString'],
          );
          csdyn.showDialogYesNo();
        }
      });
  });
}

  Future<Map> _getProximoCarimboLivre() async {
    http.Response response;

    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appGetCarimboLivre.php?tokenid=$_token&campanha=${widget.idcampanha}';
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Liberar Carimbo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Toque no botão abaixo",
                        style: TextStyle(fontSize: 26.0),
                      ),
                //Icon(Icons.arrow_drop_down_circle, size: 50.0),
                GestureDetector(
                  onTap: (){_carimboClick(context);},
                  child:  QrImage(
                    data: _carimbonovo,
                    size: 250,
                    gapless: true,
                    errorCorrectionLevel: QrErrorCorrectLevel.Q,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        height: 50.0,
                        child: RaisedButton(
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: (){_carimboClick(context);} ,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: AutoSizeText("Liberar Novo Carimbo", 
                                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                                          maxLines: 1,
                                          ),
                                ),
                                color: Colors.green
                              )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: () async {
                                      final StringBuffer sb = new StringBuffer();
                                      sb.writeln("Olá essa é uma mensagem enviada pelo aplicativo *Junta10*");
                                      sb.writeln(" ");
                                      sb.writeln("Se você está recebendo este QRCode é porque você consumiu algum produto ou serviço em nossa rede de participantes credenciada. ");                                    
                                      sb.writeln(" ");
                                      sb.writeln("Para *VISUALIZAR* seu carimbo clique no link abaixo:");
                                      sb.writeln(" ");
                                      sb.writeln("https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=$_carimbonovo");
                                      sb.writeln(" ");
                                      sb.writeln("Abra o aplicativo *Junta10* para você poder capturar o código e carimbar seu *cartão fidelidade*");
                                      sb.writeln(" ");
                                      sb.writeln("se você ainda *NÃO TEM o aplicativo Junta10* é muito fácil resolver. Clique no link abaixo para fazer o download na sua loja de aplicativos.");
                                      sb.writeln("Android => bit.ly/junta10");
                                      await Share.share(sb.toString(),
                                                        subject: "[Junta10] - Parabéns por consumir na nossa rede credenciada"
                                                      );
                                  } ,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: AutoSizeText("Compartilhar Carimbo", 
                                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                                          maxLines: 1,
                                          ),
                                ),
                                color: Colors.green
                            ),                

                      ),

                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: !_checking 
                        ? CommonDataItemTitleText("Assinatura Digital", _carimbonovo, sizetext: 14.0,)
                        : _statusLoading,
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: FutureBuilder<BannerAd>(
                          future: _bannerAd.bannerLoad(),
                          builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
                            Widget child;

                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                              case ConnectionState.active:
                                child = Container();
                                break;
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  child = AdWidget(ad: snapshot.data);
                                } else {
                                  child = Text('Error loading $BannerAd');
                                }
                            }

                            return Container(
                              width: _bannerAd.getBanner().size.width.toDouble(),
                              height: _bannerAd.getBanner().size.height.toDouble(),
                              color: Colors.blueGrey,
                              child: child,
                            );
                          },
                        ),
                      ) ,

                    ],

                  ),
                ),
                

              ],
          ),

        ],)
      ),    
    );


  }
}