import 'package:flutter/material.dart' show Colors, MaterialApp, ThemeData, runApp;
import 'package:junta192/br/com/jcv/linker/classes/storages/session_storage.dart';
import 'package:junta192/br/com/jcv/linker/classes/home/LinkerSplashScreen.dart';

void main() => runApp(new MaterialApp(
  title: "Junta1647",
  debugShowCheckedModeBanner: false,
  home: new LinkerSplashScreen(session: new SessionStorage()),
  theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.amber),

  
));

