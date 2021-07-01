import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-assistente.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';

class ComoFuncionaPage extends StatefulWidget {
  @override
  _ComoFuncionaPageState createState() => _ComoFuncionaPageState();
}

class _ComoFuncionaPageState extends State<ComoFuncionaPage> {
  @override
  Widget build(BuildContext context) {

    CommonAssistente _assistente = new CommonAssistente()
    ..addAssistentePageItem(new AssistenteModel( imgScreenShotJ10
      , 'Bem Vindo', 'Este é o Junta10 a MAIOR plataforma de Cashack, Campanhas e Recompensas. Descubra e tenha a MELHOR experiência de RETORNO EM VANTAGENS quando você gasta seu dinheiro.'))
    ..addAssistentePageItem(new AssistenteModel(imgConsumidor
      , 'Consuma o Produto', 'Você consome o produto/serviço preferido participante de uma CAMPANHA no Junta10'))
    ..addAssistentePageItem(new AssistenteModel( imgVendedorFemQrCode
      , 'Exija o QR Code', 'Na hora de realizar o pagamento, EXIJA o QR Code do Fornecedor'))
    ..addAssistentePageItem(new AssistenteModel(imgReadQrCode
      , 'Capture o seu QR Code', 'Registre no seu celular o seu QR Code usando o capturador do Junta10.'))
    ..addAssistentePageItem(new AssistenteModel(imgCheckStar
      , 'Confira seu cartão digital', 'Se quiser, confira seu cartão digital com o registro do fornecedor. Junte até completar.'));

    return Scaffold(
      appBar: new AppBar(title: Text("Como Funciona"),),
      body: _assistente,

    );
  }
}