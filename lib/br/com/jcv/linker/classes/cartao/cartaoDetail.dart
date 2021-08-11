import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos12.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos15.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos20.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos5.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoTimeline.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartaomoverhistorico/CartaoMoverHistoricoPage.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoCarimbos.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-flatbutton-pageroute.dart';

class CartaoDetail extends StatelessWidget {

  dynamic cartaofull;

  CartaoDetail(this.cartaofull);

  @override
  Widget build(BuildContext context) {
    Widget selosCarimbados;
    if(cartaofull['campanha']['maximoSelos'] == 5){
      selosCarimbados = CartaoCarimbos5(cartaofull, timestampshow: true);
    } else if(cartaofull['campanha']['maximoSelos'] == 10){
      selosCarimbados = CartaoCarimbos(cartaofull, timestampshow: true);
    } else if(cartaofull['campanha']['maximoSelos'] == 12){
      selosCarimbados = CartaoCarimbos12(cartaofull, timestampshow: true);
    } else if(cartaofull['campanha']['maximoSelos'] == 15){
      selosCarimbados = CartaoCarimbos15(cartaofull, timestampshow: true,);
    } else if(cartaofull['campanha']['maximoSelos'] == 20){
      selosCarimbados = CartaoCarimbos20(cartaofull, timestampshow: true,);
    }

    return Column(
      children: <Widget>[
        CommonDataItemTitleText("Patrocinador da campanha", cartaofull['parceiro']['apelido']),
        CommonDataItemTitleText("Título da Campanha", cartaofull['campanha']['nome']),
        CommonDataItemTitleText("Recompensa", cartaofull['campanha']['recompensa']),
        CommonDataItemTitleText("Data de Início", cartaofull['campanha']['dataInicio']),
        CommonDataItemTitleText("Data de Término Previsto", cartaofull['campanha']['dataTermino']),
        Row(
          children: <Widget>[
            CommonDataItemTitleText("ID",  cartaofull['cartao']['id'].toString()),
            SizedBox(width: 20.0,),
            CommonDataItemTitleText("Selos Registrados",  cartaofull['cartao']['contador'].toString()),
        ],),
        //new CartaoCarimbos(carimbos: cartaofull['cartao']['contador']),
        selosCarimbados,
        SizedBox(height: 20.0,),
        CommonDataItemTitleText("Descrição detalhada (Regras)", cartaofull['campanha']['textoExplicativo']),
        CommonDataItemTitleText("Última atualização do cartão",  cartaofull['cartao']['dataAtualizacao']),
        CartaoTimeline(cartaofull),
        CommonFlatButtonPageRoute(
          Icon(Icons.access_alarm), 
          "Histórico Cartão", 
          CartaoMoverHistoricoPage(cartaofull)
        )
        
      ],
      
    );
  }
}