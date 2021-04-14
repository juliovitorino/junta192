import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-status.dart';

class CommonMsgCode extends StatelessWidget {

  String msgcode;
  String msgcodeString;

  CommonMsgCode({Key key, @required this.msgcode, @required this.msgcodeString}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var icon;

    switch (msgcode) {
      case 'MSG-0001':
        icon = new IconButton(icon: Icon(Icons.check_circle, color: Colors.blueAccent,), onPressed: (){});
        break;
      case 'MSG-0042':
      case 'MSG-0063':
      case 'LNK-0042':
        icon = new IconButton(icon: Icon(Icons.cancel, color: Colors.redAccent,), onPressed: (){});
        break;
      case 'MSG-0046':
        icon = new IconButton(icon: Icon(Icons.cancel, color: Colors.redAccent,), onPressed: (){});
        break;
      case 'MSG-0049':
        icon = new IconButton(icon: Icon(Icons.card_giftcard, color: Colors.redAccent,), onPressed: (){});
        break;
      default:
        icon = new IconButton(icon: Icon(Icons.info, color: Colors.blueAccent), onPressed: (){});
    }

    return CommonStatus(icon: icon, text: msgcodeString);

  }
}