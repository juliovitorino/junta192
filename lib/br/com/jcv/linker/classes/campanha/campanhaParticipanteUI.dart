import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoAvaliacao.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';


class CampanhaParticipanteUI extends StatefulWidget {

  dynamic _cartaofull;

  CampanhaParticipanteUI(this._cartaofull);

  @override
  _CampanhaParticipanteUIState createState() => _CampanhaParticipanteUIState();
}

class _CampanhaParticipanteUIState extends State<CampanhaParticipanteUI> {
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
  void initState() {
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
    String url='${_urlControlador}appRealizarConfirmacaoRecebimentoRecompensa.php?tokenid=$_token&hash=$_hash';

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
    String url='${_urlControlador}appCartaoLike.php?tokenid=$_token&cardid=$_id_cartao';

    response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _atualizarLike() {
    _updateLike().then((mapa) {
      setState(() {
        _islike = ! _islike;
        if(_islike){
          ++_curtidas;
        }  else {
          --_curtidas;
        }
      });
    });

  }

  Future<Map> _updateFavorito() async {
    http.Response response;
    // Solicita a requisição na URL por enquanto sem callback
    String url='${_urlControlador}appCartaoFavorito.php?tokenid=$_token&cardid=$_id_cartao';

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

  Widget _createRating(int __rating, int __maxSelos ) {
    List<Icon> _lst= [];
    int n=0;
    for(int i=0; i<__rating; i++, n++){
      _lst.add(new Icon(Icons.star, size: 20.0, color: Colors.amber,));
    }
    for(int i=n; i<__maxSelos; i++){
      _lst.add(new Icon(Icons.star, size: 20.0, color: Colors.black12,));
    }
    Widget _retorno = Row(
      children: _lst,
    );
    return _retorno;

  }

  String _nomeReduzido(String nome) {
    List<String> aPartesNome = nome.split(" ");
    if(aPartesNome.length <= 2) {
      return nome;
    }

    StringBuffer sb = StringBuffer();
    for (int i = 0; i < aPartesNome.length; i++) {
      if(aPartesNome[i].length > 3) { // "String do tipo: dos do de e "
        if(i == 0 || i == aPartesNome.length-1) {
          sb.write(aPartesNome[i]);
          sb.write( " ");
        } else {
          sb.write(aPartesNome[i].substring(0,1));
          sb.write( ". ");
        }
      }     
    }
    return sb.toString();

  }



  @override
  Widget build(BuildContext context) {
    RegExp regexp = new RegExp("^us([0-9])*");
    String parsestr = widget._cartaofull['usuario']['email'];
    bool _hasmatch = regexp.hasMatch(parsestr);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left:8.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new CommonImageCircle(widget._cartaofull['usuario']['urlfoto']),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            _hasmatch
                                ? Text(_nomeReduzido(widget._cartaofull['usuario']['apelido']) + " (" +widget._cartaofull['usuario']['email'] + ")",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
                                : Text(_nomeReduzido(widget._cartaofull['usuario']['apelido']),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
                          ],
                        ),
                        _createRating(widget._cartaofull['cartao']['contador'], widget._cartaofull['campanha']['maximoSelos']),
                        Text(widget._cartaofull['cartao']['dataAtualizacao'] , style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        widget._cartaofull['cartao']['like'] == "S"
                          ? Icon(Icons.thumb_up, size: 20, color: Colors.blue,)
                          : Icon(Icons.thumb_up, size: 20, color: Colors.black26,),
                        SizedBox(height: 5,),
                        widget._cartaofull['cartao']['favorito'] == "S"
                            ? Icon(Icons.favorite, size: 20, color: Colors.red,)
                            : Icon(Icons.favorite_border, size: 20, color: Colors.red,),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
