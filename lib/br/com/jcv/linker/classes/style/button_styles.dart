import 'package:flutter/material.dart';
/// 
/// Padrão de tipografia a serem utilizadas no projeto 
/// 
/// Toda tipografia de botões.
/// 
/// Changelog:
/// 
/// @since 1.0.0
/// @author Julio Cesar Vitorino, 22/03/2021
/// 
final ButtonStyle bsEmail = TextButton.styleFrom(
  primary: Colors.white,
  backgroundColor: Colors.green[200],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 32.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
