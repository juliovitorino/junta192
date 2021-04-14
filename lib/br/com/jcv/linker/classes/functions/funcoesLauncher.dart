import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

final Function  fcnWhatsApp = (String numero, String msg) async {
  final link = WhatsAppUnilink(
    phoneNumber: numero,
    text: msg,
  );
  await launch('$link');
};