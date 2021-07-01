import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackcc/CampanhaCashbackCCVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanhasorteio/CampanhaSorteioVOPost.dart';
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

import 'CampanhaSorteioLV.dart';
import 'CampanhaSorteioPageCRUD.dart';

class CampanhaSorteioPage extends StatefulWidget {
  dynamic campanhafull;

  CampanhaSorteioPage(this.campanhafull);

  @override
  _CampanhaSorteioPageState createState() => _CampanhaSorteioPageState();
}

class _CampanhaSorteioPageState extends State<CampanhaSorteioPage> {

  String _token;
  String _urlControlador;
  String _camp_id;

  int _pag = 1;

  @override
  _CampanhaSorteioPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
    _camp_id = widget.campanhafull['id'];

  }

  Future<Map> _listCampanhaSorteio() async {
    http.Response response;
    String _url = '${_urlControlador}appListarCampanhaSorteio.php?tokenid=$_token&pag=$_pag&id_camp=$_camp_id';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Campanhas com Sorteios"),
      ),
floatingActionButton: new FloatingActionButton(
  onPressed: () {
    CampanhaSorteioVOPost campanhasorteioVO = new CampanhaSorteioVOPost(id: "0", idCampanha: _camp_id);
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new CampanhaSorteioPageCRUD(campanhasorteioVO: campanhasorteioVO) ),
    );
  },
  child: Icon(Icons.add_circle_outline),
),


      body: FutureBuilder(
        future: _listCampanhaSorteio(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new CommonLoading();
            case ConnectionState.done:
              if(snapshot.hasError) {
              }
              if(snapshot.hasData){
                return CampanhaSorteioLV(snapshot.data);
              }
              break;
            default:
              return new Container(
                height: 0.0,
                width: 0.0,
              );
          }
        },
      ),
    );
  }
}

