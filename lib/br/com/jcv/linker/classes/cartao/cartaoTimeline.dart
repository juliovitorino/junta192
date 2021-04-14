import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';

class CartaoTimeline extends StatelessWidget {

  dynamic cartaofull;
  
  CartaoTimeline(this.cartaofull);

  TimelineModel getItemCartaoTimeline(Icon icone, String titulo, String conteudo){
    return new TimelineModel(
        CommonDataItemTitleText(titulo, conteudo),
        position: TimelineItemPosition.left,
        iconBackground: Colors.greenAccent,
        icon: icone
      );
  }



  @override
  Widget build(BuildContext context) {
    List<TimelineModel> items = [];

    if(cartaofull['cartao']['status'] == "A"){
      items.add(getItemCartaoTimeline(Icon(Icons.flag),"Data de abertura do cartão",cartaofull['cartao']['dataCadastro'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.apps),"Data que completou o cartão","Cartão em aberto" ));
      items.add(getItemCartaoTimeline(Icon(Icons.check_circle),"Data de validação cartão","Aguardando..."));
      items.add(getItemCartaoTimeline(Icon(Icons.card_giftcard),"Data patrocinador entregou recompensa","Aguardando..."));
      items.add(getItemCartaoTimeline(Icon(Icons.thumb_up),"Data de confirmação de recebimento","Aguardando..."));
    } else if(cartaofull['cartao']['status'] == "0"){
      items.add(getItemCartaoTimeline(Icon(Icons.flag),"Data de abertura do cartão",cartaofull['cartao']['dataCadastro'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.apps),"Data que completou o cartão",cartaofull['cartao']['dataCompletouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.check_circle),"Data de validação cartão","Aguardando..."));
      items.add(getItemCartaoTimeline(Icon(Icons.card_giftcard),"Data patrocinador entregou recompensa","Aguardando..."));
      items.add(getItemCartaoTimeline(Icon(Icons.thumb_up),"Data de confirmação de recebimento","Aguardando..."));
    } else if(cartaofull['cartao']['status'] == "1"){
      items.add(getItemCartaoTimeline(Icon(Icons.flag),"Data de abertura do cartão",cartaofull['cartao']['dataCadastro'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.apps),"Data que completou o cartão",cartaofull['cartao']['dataCompletouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.check_circle),"Data de validação cartão",cartaofull['cartao']['dataValidouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.card_giftcard),"Data patrocinador entregou recompensa","Aguardando..."));
      items.add(getItemCartaoTimeline(Icon(Icons.thumb_up),"Data de confirmação de recebimento","Aguardando..."));
    } else if(cartaofull['cartao']['status'] == "2"){
      items.add(getItemCartaoTimeline(Icon(Icons.flag),"Data de abertura do cartão",cartaofull['cartao']['dataCadastro'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.apps),"Data que completou o cartão",cartaofull['cartao']['dataCompletouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.check_circle),"Data de validação cartão",cartaofull['cartao']['dataValidouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.card_giftcard),"Data patrocinador entregou recompensa",cartaofull['cartao']['dataEntregouRecompensa'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.thumb_up),"Data de confirmação de recebimento","Aguardando..."));
    } else if(cartaofull['cartao']['status'] == "3" || cartaofull['cartao']['status'] == "4"){
      items.add(getItemCartaoTimeline(Icon(Icons.flag),"Data de abertura do cartão",cartaofull['cartao']['dataCadastro'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.apps),"Data que completou o cartão",cartaofull['cartao']['dataCompletouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.check_circle),"Data de validação cartão",cartaofull['cartao']['dataValidouCartao'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.card_giftcard),"Data patrocinador entregou recompensa",cartaofull['cartao']['dataEntregouRecompensa'] ));
      items.add(getItemCartaoTimeline(Icon(Icons.thumb_up),"Data de confirmação de recebimento",cartaofull['cartao']['dataConfirmouRecebeuRecompensa'] ));
    }

    return new Timeline(
      shrinkWrap: true,
      children: items, 
      position: TimelinePosition.Left,
    );
  }
}