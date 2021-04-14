import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';

import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';

class CampanhaComentariosPN extends StatefulWidget {
  dynamic _campanhafull;
  bool isPositivo;
  bool isShowImage;

  CampanhaComentariosPN(this._campanhafull, {this.isPositivo=true, this.isShowImage=false});

  @override
  _CampanhaComentariosPNState createState() => _CampanhaComentariosPNState();
}

class _CampanhaComentariosPNState extends State<CampanhaComentariosPN> {

  String _token;
  String _urlControlador;
  int _campid;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
    _campid = int.parse(widget._campanhafull['id']);
  }

  Future<List> _listCampanhaComentariosPN() async {
    http.Response response;
    String _url = widget.isPositivo 
        ? '${_urlControlador}appListarCartaoComentarios.php?tokenid=${_token}&campid=${_campid}&ispositivo=(3,4,5)&qtd=30'
        : '${_urlControlador}appListarCartaoComentarios.php?tokenid=${_token}&campid=${_campid}&ispositivo=(1,2)&qtd=30';
    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }


  @override
  Widget build(BuildContext context) {
    Widget rodape = new Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Center(child: new Text(widget._campanhafull['recompensa'].toString(),
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)
        )
      )
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Column(
        children: <Widget>[
          new FutureBuilder(
              future: _listCampanhaComentariosPN(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                debugPrint("Voltei do future");
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return new CommonLoading();
                  case ConnectionState.done:
                    if(snapshot.hasError) {
                      debugPrint("erro" + snapshot.error.toString());
                      return new CommonLoading();
                    }
                    if(snapshot.hasData){
                      debugPrint(jsonEncode(snapshot.data));
                      return ComentarioLV(snapshot.data, isShowImage: widget.isShowImage);
                    }
                    break;
                  default:
                    return new Container(
                      height: 0.0,
                      width: 0.0,
                    );
                }
              }
          ),
          //new AdsRoyalTypeOne(widget._campanhafull['id'], widget._campanhafull['img'],widget._campanhafull['nome'],  rodape, ),
        ],
      ),
    );
  }
}

class ComentarioLV extends StatelessWidget {

  List _lst;
  bool isShowImage;

  ComentarioLV(this._lst, {this.isShowImage=false});

  Widget _createRating(String __rating ) {
    int _rating = int.parse(__rating);
    List<Icon> _lst= [];
    int n=0;
    for(int i=0; i<_rating; i++, n++){
      _lst.add(new Icon(Icons.star, size: 24.0, color: Colors.amber,));
    }
    for(int i=n; i<5; i++){
      _lst.add(new Icon(Icons.star, size: 24.0, color: Colors.black12,));
    }
    Widget _retorno = Row(
      children: _lst,
    );
    return _retorno;

  }

  @override
  Widget build(BuildContext context) {
    return _lst.length == 0
        ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum avaliação encontrada.")
        : new Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: new ListView.builder(
                itemCount: _lst.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.only(left:8.0, top: 10.0, bottom: 10.0, right: 8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  isShowImage
                                      ? new CommonImageCircle(_lst[index]['usuario']['urlfoto'])
                                      : new Container(height: 0.0, width: 0.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.person),
                                          Text(_lst[index]['usuario']['apelido'],
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
                                        ],
                                      ),
                                      _createRating(_lst[index]['cartao']['rating']),
                                      Text(_lst[index]['cartao']['dataRating'], style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0,),
                              Text(_lst[index]['cartao']['comentario']),
                            ],
                          )
                      ),
                    )
                  );
                }
            ),
    );
  }
}
