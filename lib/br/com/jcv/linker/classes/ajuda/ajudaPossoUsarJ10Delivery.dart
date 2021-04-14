import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-assistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class AjudaPossoUsarDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CommonAssistente _assistente = new CommonAssistente()
    ..addAssistentePageItem(new AssistenteModel( imgPronto
      , 'É Claro!', 'Veja como o Junta10 pode ajudar AUMENTAR SUAS VENDAS e ainda GARANTIR A FIDELIDADE DOS SEUS CLIENTES'))
    ..addAssistentePageItem(new AssistenteModel(imgDlvryClienteFazPedido
      , 'O cliente faz o pedido', 'O pedido é feito pelo celular ou a partir dos aplicativos de pedir comida ou serviços'))
    ..addAssistentePageItem(new AssistenteModel( imgDlvryMotoboyVai
      , 'Preparo e Entrega', 'Prepara-se o produto ou serviço e o embale para entrega JUNTAMENTE COM UM CÓDIGO IMPRESSO do Junta10'))
    ..addAssistentePageItem(new AssistenteModel(imgDlvryMotoboyVolta
      , 'Entrega a Domicílio', 'Motoboy faz a entrega do pedido e recebe pagamento (se necessário). O cliente com o aplicativo Junta10 faz a captura do código que seu estabelecimento enviou.'))
    ..addAssistentePageItem(new AssistenteModel(imgDlvryClienteRegistrado
      , 'Então...', 'O cliente confere a CARTELA DIGITAL e começa a juntar seus carimbos para que possa RESGATAR A RECOMPENSA assim que ele COMPLETAR O CARTÃO'))
    ..addAssistentePageItem(new AssistenteModel(imgPronto
      , 'Pronto!', 'Viu como é FÁCIL E RÁPIDO usar o Junta10 dentro do seu negócio... Vamos lá!'));

    return Scaffold(
      appBar: new AppBar(title: Text("Posso usar no meu Delivery?"),),
      body: _assistente,

    );
  }
}