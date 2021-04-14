import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/CampanhaPerformanceDetail.dart';


class CampanhaPerformancePage extends StatelessWidget {
  dynamic _cartaofull;

  CampanhaPerformancePage(this._cartaofull);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Performance da Campanha"),
      ),
      body: new CampanhaPerformanceDetail(_cartaofull),
    );
  }
}
