import 'dart:convert';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/functions/funcoesAjuda.dart';

import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaDetailPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPerformancePage.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaGetCarimbo.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaPageEdit.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/ads/ads-royal-typeOne.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-showdialog.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/specifics/LinkerDataItemBottom.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaComentariosPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/usuarioautorizador/UsuarioAutorizadorPage.dart';

import 'campanhaParticipantesPage.dart';

class CampanhaItemUI extends StatefulWidget {

  dynamic _campanhafull;

  CampanhaItemUI(this._campanhafull);

  @override
  _CampanhaItemUIState createState() => _CampanhaItemUIState();
}

class _CampanhaItemUIState extends State<CampanhaItemUI> {
  String _token;
  String _urlControlador;
  Widget _btnAction;
  List<Widget> _lstToolbar = [];
  bool _showbtn = true;

  @override
  void initState(){
    super.initState();
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = GlobalStartup().getGateway() + "/";
  }

  Future<Map> _criarCarimbosCampanha(int id) async {
    String url='${_urlControlador}appCriarCarimbosPorId.php?tokenid=$_token&camp=$id';
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _criarCarimbosCampanhaClick(BuildContext context){

    CommonShowDialogYesNo retorno = new CommonShowDialogYesNo(
      context: context,
      icon: Icon(Icons.help_outline, size: 120.0, color: Colors.green,),
      msg: "Criar os carimbos para iniciar a distribuição de carimbos da campanha?",
      textYes: "Sim",
      textNo: "Não",
    );

    retorno.showDialogYesNo().then((onValue){
        if(retorno.getChoice() == 'Y'){
          setState(() {
            _showbtn = false; 
            //print(_showbtn ? "LIGADO" : "DESLIGADO");
          });
          final snackBar = SnackBar(content: Text('Seus carimbos entraram em processo de produção. Aguarde a conclusão para iniciar a liberação da campanha.'));
          Scaffold.of(context).showSnackBar(snackBar);
          _criarCarimbosCampanha(int.parse(widget._campanhafull['id'])).then((retorno){
            Icon _icon = retorno['msgcode'] == 'MSG-0001' 
            ? Icon(Icons.check_circle_outline, size: 120.0, color: Colors.green,)
            : Icon(Icons.error, size: 120.0, color: Colors.red,);

            CommonShowDialogYesNo csdyn = CommonShowDialogYesNo(
                  context: context,
                  icon: _icon,
                  msg: retorno['msgcodeString']
                );
            csdyn.showDialogYesNo();
          });
        }
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    _lstToolbar.add(new LinkerDataItemBottom(
                          Icons.help, 
                          "Ajuda", 
                          funcaoAction: () => fcnAcionarAjudaPrincipalCampanha(context)
                        )
                  );

    // Opções do Admin
    if(widget._campanhafull['status'] == 'A' ){
      _lstToolbar.add(new LinkerDataItemBottom(Icons.edit, "Editar", pageAction: new CampanhaPageEdit(widget._campanhafull)));

      if(CacheSession().getSession()['tipousuario'] == "P"){
        _lstToolbar.add(new LinkerDataItemBottom(Icons.lock_open, "Autorizadores", pageAction: new UsuarioAutorizadorPage(widget._campanhafull['id'])));
        _lstToolbar.add(new LinkerDataItemBottom(Icons.monetization_on, "Cashback", pageAction: new CampanhaDetailPage(widget._campanhafull, acao: "S")));
      }
      
      if(int.parse(widget._campanhafull['totalCarimbados']) == 0 && int.parse(widget._campanhafull['totalCarimbos']) > 0){
        _lstToolbar.add(new LinkerDataItemBottom(Icons.cancel , "Cancelar",pageAction: new CampanhaDetailPage(widget._campanhafull, acao: "C",)));

      }
      _btnAction = new CommomActionButton(
                        titulo: "Liberar Carimbos", 
                        onpressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => 
                                new GetCarimboLivrePage(session: new SessionStorage(), idcampanha:int.parse(widget._campanhafull['id']))),
                              );            

                          });    
    } else if(widget._campanhafull['status'] == 'F' ){
      _lstToolbar.add(new LinkerDataItemBottom(Icons.edit, "Editar", pageAction: new CampanhaPageEdit(widget._campanhafull)));
      _lstToolbar.add(new LinkerDataItemBottom(Icons.delete_forever , "Excluir",pageAction: new CampanhaDetailPage(widget._campanhafull, acao: "E",)));
      _btnAction = new CommomActionButton(
                        titulo: "Criar Carimbos", 
                        onpressed: (){
                            _criarCarimbosCampanhaClick(context);
                          });      
    } else {
      _lstToolbar.add(new LinkerDataItemBottom(Icons.archive , "Arquivar"));
      _btnAction = new Container(width: 0, height: 0,);
    }

    // Opções disponiveis somente para usuário membros e premium
    if(    ( CacheSession().getSession()['tipousuario'] == "C" )
        && ( CacheSession().getSession()['isGratuito'] == '0' )
        || ( CacheSession().getSession()['tipousuario'] == "P" )
    ){
      _lstToolbar.add(new LinkerDataItemBottom(Icons.offline_bolt, "Performance", pageAction: new CampanhaPerformancePage(widget._campanhafull)));
    }
    
    _lstToolbar.add(new LinkerDataItemBottom(Icons.info, "Detalhes", pageAction: new CampanhaDetailPage(widget._campanhafull)));
    _lstToolbar.add(new LinkerDataItemBottom(Icons.record_voice_over, "Comentários", pageAction: new CampanhaComentariosPage(widget._campanhafull, isShowImage: true)));
    _lstToolbar.add(new LinkerDataItemBottom(Icons.people, "Participantes", pageAction: new CampanhaParticipantesPage(widget._campanhafull)));
    double _percmetacarimbos = int.parse(widget._campanhafull['totalCarimbos']) == 0
          ? 0
          : int.parse(widget._campanhafull['totalCarimbados']) / int.parse(widget._campanhafull['totalCarimbos']) * 100;
    double _percmetacartao = widget._campanhafull['maximoCartoes'] == 0
          ? 0
          : widget._campanhafull['contadorCartoes'] / widget._campanhafull['maximoCartoes'] * 100;
    Widget rodape = new Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Center(child: new AutoSizeText(widget._campanhafull['recompensa'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                      maxLines: 2,)
      )
    );
    
    return new Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: Card(
                child: new Container(
                  padding: new EdgeInsets.all(16.0),
                  child: new Column(
                    children: <Widget>[
                      new AdsRoyalTypeOne(widget._campanhafull['id'], widget._campanhafull['img'],widget._campanhafull['nome'],  rodape, isGetImagem: true ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.thumb_up, color: Colors.blue),
                              SizedBox(width: 5.0,),
                              Text( widget._campanhafull['contadorLike'].toString() + " pessoas curtiram a campanha" ),
                            ],
                          ),
                        ),

                      new Divider(),
                      new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: new Row(children: _lstToolbar),
                      ),
                      _showbtn ? _btnAction : Container(height: 0, width: 0),
                    ],
                  ),
                ),
              )
    );
  }
}

class CartaoCarimbos extends StatefulWidget {

  var lstmarcados = [0,0,0,0,0,0,0,0,0,0];

  int carimbos;
  CartaoCarimbos({int this.carimbos = 0}){
    for (int i = 0; i < this.carimbos; i++){
      lstmarcados[i] = 1;
    }
  }

  @override
  _CartaoCarimbosState createState() => _CartaoCarimbosState();
}

class _CartaoCarimbosState extends State<CartaoCarimbos> {

  final double SIZE_CARIMBO = 60.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.star, color: widget.lstmarcados[0] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[1] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[2] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[3] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[4] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star, color: widget.lstmarcados[5] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[6] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[7] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[8] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
            Icon(Icons.star, color: widget.lstmarcados[9] == 1 ? Colors.blue : Colors.grey, size: SIZE_CARIMBO,),
          ],
        ),
        
        
      ],
      
    );
  }
}