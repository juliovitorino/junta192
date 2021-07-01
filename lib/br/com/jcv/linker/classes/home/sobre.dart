import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _token = CacheSession().getSession()['tokenid'];
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
                  CommonDataItemTitleText("SSID", _token.substring(0,4) + "******" + _token.substring(_token.length-4, _token.length)),
                  CommonDataItemTitleText("Código de indicação", CacheSession().getSession()['usuariodto']['id']),
                  Platform.isIOS
                  ? CommonDataItemTitleText("Requer Dispositivo", "iPhone 7 ou superior")
                  : CommonDataItemTitleText("Requer Android", "6.0 (Marshmellow) ou superior"),
                ],
              ),
      ),
    );
  }
}