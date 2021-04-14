import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cartao/cartaoSeloDetail.dart';

class CartaoSeloPage extends StatefulWidget {

  dynamic selofull;

  CartaoSeloPage(this.selofull);

  @override
  _CartaoSeloPageState createState() => _CartaoSeloPageState();
}

class _CartaoSeloPageState extends State<CartaoSeloPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Detalhes do Selo"),
      ),
      body: new CartaoSeloDetail(widget.selofull),
    );
  }
}

