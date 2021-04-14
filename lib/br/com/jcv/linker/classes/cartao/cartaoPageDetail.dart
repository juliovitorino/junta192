import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoDetail.dart';

class CartaoPageDetail extends StatelessWidget {
  dynamic cartaofull;

  CartaoPageDetail(this.cartaofull);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Detalhes do Cartão"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: new CartaoDetail(cartaofull),
      ),
      
    );
  }
}