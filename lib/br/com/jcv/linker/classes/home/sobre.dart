import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
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
              child: Column(
                children: <Widget>[
                  CommonDataItemTitleText("Versão", GlobalStartup().getVersao()),
                ],
              ),
      ),
    );
  }
}