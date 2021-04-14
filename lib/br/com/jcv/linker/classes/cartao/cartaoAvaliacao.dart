import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoAvaliacaoPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/ads/ads-royal-typeOne.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';

Future<CartaoAvaliacaoPost> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao submeter dados ao servidor.");
    }
    return CartaoAvaliacaoPost.fromJson(json.decode(response.body));
  });
}

class CartaoAvaliacao extends StatefulWidget {

  dynamic _cartaofull;

  CartaoAvaliacao(this._cartaofull);

  void setCartaoFull(dynamic _cartaofull){
    this._cartaofull = _cartaofull;
  }

  @override
  _CartaoAvaliacaoState createState() => _CartaoAvaliacaoState();
}

class _CartaoAvaliacaoState extends State<CartaoAvaliacao> {
    Icon _icon1;
    Icon _icon2;
    Icon _icon3;
    Icon _icon4;
    Icon _icon5;
    String _avaliacao = "Clique nas Estrelas acima";
    String _token;
    String _urlControlador;
    TextEditingController _comentarioControler = new TextEditingController();

    int _starClicked=0;
    Icon _iconStarClose = new Icon( Icons.star, color: Colors.amber, size: 60);
    Icon _iconStarOpen = new Icon( Icons.star_border, color: Colors.black12, size: 60);

    @override
    void initState(){
      super.initState();
      _icon1 = _iconStarOpen;
      _icon2 = _iconStarOpen;
      _icon3 = _iconStarOpen;
      _icon4 = _iconStarOpen;
      _icon5 = _iconStarOpen;
      _token = CacheSession().getSession()['tokenid'];
      _urlControlador = GlobalStartup().getGateway() + "/";

    }    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child: Text("Avaliar Campanha")),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: Column(
          children: <Widget>[
            Text("Ajude-nos a melhorar nosso atendimento", style: TextStyle(fontSize:16.0)),
            Text("Este é MOMENTO CERTO para sua avaliação", style: TextStyle(fontSize:16.0,fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0,),
            new AdsRoyalTypeOne(widget._cartaofull['campanha']['id'],widget._cartaofull['campanha']['img'],widget._cartaofull['campanha']['nome'],
                        Text(widget._cartaofull['campanha']['recompensa'], 
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),) 
                      ),

            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _starClicked = 1;
                    _avaliacao = "Ooops! PÉSSIMO";
                    setState(() {
                      _icon1 = _iconStarClose;
                      _icon2 = _iconStarOpen;
                      _icon3 = _iconStarOpen;
                      _icon4 = _iconStarOpen;
                      _icon5 = _iconStarOpen;
                    });
                  },
                  child: _icon1,
                ),
                GestureDetector(
                  onTap: (){
                    _starClicked = 2;
                    _avaliacao = "RUIM";
                    setState(() {
                      _icon1 = _iconStarClose;
                      _icon2 = _iconStarClose;
                      _icon3 = _iconStarOpen;
                      _icon4 = _iconStarOpen;
                      _icon5 = _iconStarOpen;
                    });
                  },
                  child: _icon2,
                ),
                GestureDetector(
                  onTap: (){
                    _starClicked = 3;
                    _avaliacao = "BOM";
                    setState(() {
                      _icon1 = _iconStarClose;
                      _icon2 = _iconStarClose;
                      _icon3 = _iconStarClose;
                      _icon4 = _iconStarOpen;
                      _icon5 = _iconStarOpen;
                    });
                  },
                  child: _icon3,
                ),
                GestureDetector(
                  onTap: (){
                    _starClicked = 4;
                    _avaliacao = "ÓTIMO";
                    setState(() {
                      _icon1 = _iconStarClose;
                      _icon2 = _iconStarClose;
                      _icon3 = _iconStarClose;
                      _icon4 = _iconStarClose;
                      _icon5 = _iconStarOpen;
                    });
                  },
                  child: _icon4,
                ),
                GestureDetector(
                  onTap: (){
                    _starClicked = 5;
                    _avaliacao = "UAU!!!";
                    setState(() {
                      _icon1 = _iconStarClose;
                      _icon2 = _iconStarClose;
                      _icon3 = _iconStarClose;
                      _icon4 = _iconStarClose;
                      _icon5 = _iconStarClose;

                    });
                  },
                  child: _icon5,
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Text("$_avaliacao", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: TextField(
                    controller: _comentarioControler,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                          labelText: "Deixe seu comentários para outros conhecerem",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder()
                      ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                  ),
                ),
              ),
              new CommomActionButton(titulo: "Enviar Avaliação", 
                  onpressed: () async {
                  CartaoAvaliacaoPost newPost = new CartaoAvaliacaoPost(
                      tokenid: _token,
                      hash: widget._cartaofull['cartao']['hashresgate'], 
                      rating: _starClicked.toString(), 
                      comentario: _comentarioControler.text);
                  CartaoAvaliacaoPost p = await createPost('${_urlControlador}appRealizarAvaliacaoCartao.php', body: newPost.toMap());
                  Icon _icon = p.msgcode == 'MSG-0092' 
                  ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
                  : Icon(Icons.error, size: 120.0, color: Colors.red,);

                  CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
                    context: context,
                    icon: _icon,
                    msg: p.msgcodeString,
                  );

                  retorno.showDialogYesNo().then((onValue){
                      if(retorno.getChoice() == 'Y'){
                        Navigator.pop(context);
                      }
                    }
                  );
                }),
              SizedBox(height: 20.0,),


          ],
        ),
      ),
    );
  }
}