import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
      ),
      body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Column(
                children: <Widget>[
                  CommonDataItemTitleText("Ambiente Gateway Ativo", GlobalStartup().getAmbienteAtivo()),
                  CommonDataItemTitleText("Versão", GlobalStartup().getVersaoMin()),
                  CommonDataItemTitleText("Versão Build", GlobalStartup().getVersao()),
                  Platform.isIOS
                  ? CommonDataItemTitleText("Requer Dispositivo", "iPhone 7 ou superior")
                  : CommonDataItemTitleText("Requer Android", "6.0 (Marshmellow) ou superior"),
                ],
              ),
      ),
    );
  }
}