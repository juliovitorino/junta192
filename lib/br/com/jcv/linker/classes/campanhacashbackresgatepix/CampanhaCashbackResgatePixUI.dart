import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanhacashbackresgatepix/CampanhaCashbackResgatePixVOPost.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-function.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';

class CampanhaCashbackResgatePixUI extends StatefulWidget {

  dynamic _campanhacashbackresgatepixVO;

  CampanhaCashbackResgatePixUI(this._campanhacashbackresgatepixVO);

  @override
  _CampanhaCashbackResgatePixUIState createState() => _CampanhaCashbackResgatePixUIState();
}

class _CampanhaCashbackResgatePixUIState extends State<CampanhaCashbackResgatePixUI> {

  String _token;
  String _urlControlador;
   bool _isVisibleActionBtn = false;

  @override
  initState() {
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];
  }

  @override
  Widget build(BuildContext context) {

    // Toolbar com botões de ação
    Widget _widActionBtn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonFlatButtonFunction(Icon(Icons.edit, color: Colors.white), "Editar", (){}),
        CommonFlatButtonFunction(Icon(Icons.cancel, color: Colors.white), "Apagar", (){}),
      ],
    );

    final vo = CampanhaCashbackResgatePixVOPost.fromJson(widget._campanhacashbackresgatepixVO);

    String dtApresentar;
    Color corEstagio;
    Color corMsgAcompanhamento;
    switch (vo.estagioRealTime) {
      case '0':
        dtApresentar = vo.dataCadastro;
        corEstagio = Colors.red;
        corMsgAcompanhamento = Colors.black54;
        break;
      case '1':
        dtApresentar = vo.dtEstagioAnalise;
        corEstagio = Colors.blue;
        corMsgAcompanhamento = Colors.black54;
        break;
      case '2':
        dtApresentar = vo.dtEstagioFinanceiro;
        corEstagio = Colors.blue;
        corMsgAcompanhamento = Colors.black54;
        break;
      case '3':
        dtApresentar = vo.dtEstagioErro;
        corEstagio = Colors.red;
        corMsgAcompanhamento = Colors.red;
        break;
      case '4':
        dtApresentar = vo.dtEstagioTranfBco;
        corEstagio = Colors.green;
        corMsgAcompanhamento = Colors.green;
        break;
      default:
        dtApresentar = vo.dataCadastro;
        corEstagio = Colors.black;
        corMsgAcompanhamento = Colors.black54;
    }
    
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:8.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    /*new CommonImageCircle("no-user.png"
                        ,heightcic: 64
                        ,widthcic: 64
                        ,bordercolorcic: Colors.transparent),
                    SizedBox(width: 8,),*/
                    Expanded(child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonDataItemTitleText("Estágio da sua solicitação", vo.estagioRealTimeDesc, color: corEstagio ),
                          CommonDataItemTitleText("Data da mudança de estágio", dtApresentar ),
                          CommonDataItemTitleText("Mensagem de acompanhamento", vo.txtLivreEstagioRT, color: corMsgAcompanhamento ),
                          CommonDataItemTitleText("Chave PIX", vo.tipoChavePixDesc + ' = ' + vo.chavePix ),
                          CommonDataItemTitleText("Valor de resgate solicitado", vo.valorResgateCurrency ),
                          CommonDataItemTitleText("Data e hora da solicitação", vo.dataCadastro ),
                          CommonDataItemTitleText("Registro de transação bancária", vo.autenticacaoBco, sizetext: 12.0, ),
                          /*
                          Text(vo.dtEstagioFinanceiro,style: TextStyle(fontSize: 14, color: Colors.black)),
                          Text(vo.dtEstagioErro ,style: TextStyle(fontSize: 14, color: Colors.black)),
                          Text(vo.dtEstagioTranfBco,style: TextStyle(fontSize: 14, color: Colors.black)),
*/
                        ],
                      ),                    
                    ),
                    IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                      setState(() {
                         _isVisibleActionBtn = !_isVisibleActionBtn;

                      });
                    },)
                  ],
                ),
                SizedBox(height: 10,),
                _isVisibleActionBtn ? _widActionBtn : Container(height: 0, width: 0,)
              ],
            ),
          ),
        )
    );
  }
}


