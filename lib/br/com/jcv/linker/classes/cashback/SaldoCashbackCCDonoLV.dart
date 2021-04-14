import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/cashback/SaldoCashbackCCDonoUI.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-image-circle.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-msgcode.dart';


class SaldoCashbackCCDonoLV extends StatefulWidget {

  dynamic data;

  SaldoCashbackCCDonoLV(this.data);

  @override
  _SaldoCashbackCCDonoLVState createState() => _SaldoCashbackCCDonoLVState();
}

class _SaldoCashbackCCDonoLVState extends State<SaldoCashbackCCDonoLV> {
  @override
  Widget build(BuildContext context) {

    Widget _widget = new SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Text("Saldo Cashback"),
          Text(widget.data['vlsldGeralMoeda'].toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black)),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CommonImageCircle(widget.data['usuario']['urlfoto']
                  ,heightcic: 64
                  ,widthcic: 64
                  ,bordercolorcic: Colors.transparent),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.data['usuario']['apelido'] ,
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45)),
                  Text(widget.data['usuario']['email'].toString() ,
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),

            ],
          ),

          // ListView com o saldo
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: ListView.builder(
              itemCount: widget.data['sldUsuarioDono'].length,
              itemBuilder: (BuildContext context, int index){
                print("aui");
                return widget.data['sldUsuarioDono'].length == 0
                    ? new CommonMsgCode(msgcode: "LNK-0042", msgcodeString: "Nenhum movimento encontrado.")
                    : SaldoCashbackCCDonoUI(int.parse(widget.data['usuario']['id']), widget.data['sldUsuarioDono'][index]);
              },
            ),
          ),
        ],
      ),
    );

    return _widget;
  }
}
