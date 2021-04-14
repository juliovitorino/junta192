import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoAvaliacao.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos12.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos15.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos20.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos5.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/ads/ads-royal-typeOne.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDataItem.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDataItemBottom.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoPageDetail.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoPageResgate.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/rating/rating-indicator.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaComentariosPage.dart';

class CartaoCampanhaUI extends StatefulWidget {

  dynamic _cartaofull;

  CartaoCampanhaUI(this._cartaofull);

  @override
  _CartaoCampanhaUIState createState() => _CartaoCampanhaUIState();
}

class _CartaoCampanhaUIState extends State<CartaoCampanhaUI> {
  int _curtidas;
  bool _islike;
  bool _isfavorito;
  bool _israting;
  int _id_cartao;
  String _token;
  String _urlControlador;
  int _totalrating;
  String _hash;

  @override
  initState() {
    super.initState();
    _curtidas = widget._cartaofull['campanha']['contadorLike'];
    _islike = widget._cartaofull['cartao']['like'] == 'S';
    _isfavorito = widget._cartaofull['cartao']['favorito'] == 'S';
    _id_cartao = widget._cartaofull['cartao']['id'];
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _hash = widget._cartaofull['cartao']['hashresgate'];
    _israting = false;
  }

  Future<Map> _confirmaRecebimento() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appRealizarConfirmacaoRecebimentoRecompensa.php?tokenid=${_token}&hash=${_hash}';
    
    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _confirmarRecebimentoClick() {
    _confirmaRecebimento().then((mapa) {
      CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
              context: context,
              icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
              msg: mapa['msgcodeString']
      );
      escolha.showDialogYesNo().then((mapa){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new CartaoAvaliacao(widget._cartaofull) ),
              );

      });
      switch (mapa['msgcode']) {
        case "MSG-0068":
          break;
        default:
      }
    });
  }

  Future<Map> _updateLike() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appCartaoLike.php?tokenid=${_token}&cardid=${_id_cartao}';

    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _atualizarLike() {
    _updateLike().then((mapa) {
      setState(() {
        _islike = ! _islike;
        if(_islike){
          ++_curtidas;
          Scaffold.of(context).showSnackBar(
              new SnackBar(content: Text("Seu cartão foi marcado com Curtir na campanha " + widget._cartaofull['campanha']['nome']))
          );
        }  else {
          --_curtidas;
          Scaffold.of(context).showSnackBar(
              new SnackBar(content: Text("Seu cartão foi desmarcado com Curtir na campanha " + widget._cartaofull['campanha']['nome']))
          );
        }
      });
    });

  }

  Future<Map> _updateFavorito() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appCartaoFavorito.php?tokenid=${_token}&cardid=${_id_cartao}';

    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _atualizarFavorito(BuildContext context) {
    _updateFavorito().then((mapa) {
        setState(() {
          _isfavorito = ! _isfavorito;
        });
        if(_isfavorito){
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Seu cartão foi adicionado ao favoritos. Ele irá aparecer na próxima carga"))
          );
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Seu cartão foi removido dos favoritos. Ele irá desaparecer na próxima carga"))
          );
        }
    });

  }


  @override
  Widget build(BuildContext context) {
    Widget _btnAcaoPermitida = new Container(width: 0, height: 0,);
    Widget selosCarimbados;
    if(widget._cartaofull['campanha']['maximoSelos'] == 5){
      selosCarimbados = CartaoCarimbos5(widget._cartaofull);
    } else if(widget._cartaofull['campanha']['maximoSelos'] == 10){
      selosCarimbados = CartaoCarimbos(widget._cartaofull);
    } else if(widget._cartaofull['campanha']['maximoSelos'] == 12){
      selosCarimbados = new CartaoCarimbos12(widget._cartaofull);
    } else if(widget._cartaofull['campanha']['maximoSelos'] == 15){
      selosCarimbados = CartaoCarimbos15(widget._cartaofull);
    } else if(widget._cartaofull['campanha']['maximoSelos'] == 20){
      selosCarimbados = CartaoCarimbos20(widget._cartaofull);
    }

    if (widget._cartaofull['cartao']['status'] == '0' || widget._cartaofull['cartao']['status'] == '1'){
      _btnAcaoPermitida = Container(
                        padding: EdgeInsets.only(top: 10.0),
                        height: 50.0,
                        child: RaisedButton(
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => 
                                      new CartaoPageResgate(widget._cartaofull)),
                                    );            

                                } ,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(widget._cartaofull['cartao']['status'] == '0' ? "Resgatar Recompensa" : "Continuar Resgate", 
                                          style: TextStyle(color: Colors.white, fontSize: 25.0)),
                                ),
                                color: Colors.green
                              )
                      );

    } else if (widget._cartaofull['cartao']['status'] == '3' && widget._cartaofull['cartao']['rating'] == '0'){
      _btnAcaoPermitida = Container(
                        padding: EdgeInsets.only(top: 10.0),
                        height: 50.0,
                        child: RaisedButton(
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                    new CartaoAvaliacao(widget._cartaofull)),
                                  );

                                } ,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text("Avaliar Campanha",
                                          style: TextStyle(color: Colors.white, fontSize: 25.0)),
                                ),
                                color: Colors.green
                              )
                      );

    } else if (widget._cartaofull['cartao']['status'] == '2'){
      _btnAcaoPermitida = Container(
          padding: EdgeInsets.only(top: 10.0),
          height: 50.0,
          child: RaisedButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              onPressed: (){
                CommonShowDialogYesNo escolha = CommonShowDialogYesNo(
                  context: context,
                  icon: Icon(Icons.thumb_up, size: 120.0, color: Colors.blue) ,
                  msg: "Você confirma que recebeu a recompensa?",
                  textYes: "Sim",
                  textNo: "Não",
                );
                escolha.showDialogYesNo().then((onValue){
                  if(escolha.getChoice() == 'Y'){
                    _confirmarRecebimentoClick();
                  }
                });
              } ,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Confirmar Recebimento",
                    style: TextStyle(color: Colors.white, fontSize: 25.0)),
              ),
              color: Colors.green
          )
      );

    }

    Widget rodape = new Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Center(child: new Text(widget._cartaofull['campanha']['recompensa'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),)
      )
    );

    _totalrating = widget._cartaofull['campanha']['contadorStar_1'] + 
     widget._cartaofull['campanha']['contadorStar_2'] + 
     widget._cartaofull['campanha']['contadorStar_3'] + 
     widget._cartaofull['campanha']['contadorStar_4'] + 
     widget._cartaofull['campanha']['contadorStar_5'];

    return new Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: Card(
                child: new Container(
                  padding: new EdgeInsets.all(16.0),
                  child: new Column(
                    children: <Widget>[
                      new CommonDataItemTitleText("PATROCINADOR", widget._cartaofull['parceiro']['apelido'], sizetext: 18.0,),
                      //new CommonDataItemTitleText("CAMPANHA", widget._cartaofull['campanha']['nome']),
                      new AdsRoyalTypeOne(widget._cartaofull['campanha']['id'],widget._cartaofull['campanha']['img'],'CAMPANHA',
                        Text(widget._cartaofull['campanha']['nome'], 
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),) 
                      ),
                      new Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: OutlineButton(
                            onPressed: _atualizarLike,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.thumb_up, color: _islike ? Colors.blue : Colors.black45),
                                SizedBox(width: 5.0,),
                                Text(_islike ? "($_curtidas)" : "Curtir" ,
                                  style: TextStyle(color: _islike ? Colors.blue : Colors.black)),
                              ],
                            ),
                          )
                        ),
                        //Text("($_curtidas) curtidas" ),
                        SizedBox(width: 10.0,),
                        new OutlineButton(
                          onPressed: (){
                            setState(() {
                              _israting = !_israting;
                            });
                          },
                          child: new Row(
                            children: <Widget>[
                              SizedBox(width: 10.0,),
                              Text(widget._cartaofull['campanha']['ratingCalculado'].toString()),
                              SizedBox(width: 2.0,),
                              Icon(Icons.star, color: Colors.amber),
                              Text("($_totalrating)"),
                              Icon(Icons.person, color: Colors.blue),
                            ],
                          ),
                        ),
                        IconButton(icon: _isfavorito
                            ? Icon(Icons.favorite, color: Colors.red,)
                            : Icon(Icons.favorite_border, color: Colors.black26,)
                            , onPressed: ()=>_atualizarFavorito(context))

                      ],),
                      _israting
                      ? Column(
                        children: <Widget>[
                          new RatingIndicator(widget._cartaofull['campanha']['contadorStar_1'],
                            widget._cartaofull['campanha']['contadorStar_2'],
                            widget._cartaofull['campanha']['contadorStar_3'],
                            widget._cartaofull['campanha']['contadorStar_4'],
                            widget._cartaofull['campanha']['contadorStar_5']),
                          SizedBox(height: 5.0,),
                          CommomActionButton(titulo: "Ver comentários", onpressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => new CampanhaComentariosPage(widget._cartaofull['campanha'])));
                          }),
                          SizedBox(height: 5.0,),
                        ],
                        )
                      : Container(height: 0, width: 0,),

                      new LinkerDataItem(Icons.call_to_action, widget._cartaofull['cartao']['id'].toString() 
                              + ' - ' 
                              + widget._cartaofull['cartao']['statusdesc']),
                      new LinkerDataItem(Icons.card_giftcard, widget._cartaofull['campanha']['recompensa']),
                      new LinkerDataItem(Icons.star, 'Complete ' + widget._cartaofull['campanha']['maximoSelos'].toString() + ' selos'),
                      selosCarimbados,
                      new Divider(),
                      new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: new Row(
                          children: <Widget>[
                            new LinkerDataItemBottom(Icons.info , "Detalhes", pageAction: new CartaoPageDetail(widget._cartaofull)),
                            //new LinkerDataItemBottom(Icons.compare_arrows , "Transferir",null),
                            //new LinkerDataItemBottom(Icons.record_voice_over , "Denunciar",null),
                        ],),
                      ),
                      _btnAcaoPermitida
                      
                    ],
                  ),
                ),
              )
    );
  }
}
