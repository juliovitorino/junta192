import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cashback/SaldoCashbackCCUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';


class SaldoCashbackCCLV extends StatefulWidget {

  dynamic data;

  SaldoCashbackCCLV(this.data);

  @override
  _SaldoCashbackCCLVState createState() => _SaldoCashbackCCLVState();
}

class _SaldoCashbackCCLVState extends State<SaldoCashbackCCLV> {
  @override
  Widget build(BuildContext context) {

    Widget _widget = SingleChildScrollView(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Text("Saldo Cashback"),
          Text(widget.data['vlsldGeralMoeda'] == null ? "BRL \$0,00" : widget.data['vlsldGeralMoeda'].toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black)),
          Container(
            height: MediaQuery.of(context).size.height * 0.67,
            child: ListView.builder(
              itemCount: widget.data['sldUsuarioDono'].length,
              itemBuilder: (BuildContext context, int index){
                return widget.data['sldUsuarioDono'].length == 0
                    ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum movimento encontrado.")
                    : SaldoCashbackCCUI(widget.data['sldUsuarioDono'][index]);
              },
            ),
          ),
        ],
      ),
    );

    return _widget;
  }
}
