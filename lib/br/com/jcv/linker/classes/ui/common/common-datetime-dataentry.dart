// Julio Vitorino, Sep, 25th 2019
import 'package:flutter/material.dart';

enum ModoDataenry {
  linear,
  empilhado
}

// função auxiliar para fazer um parse de formato
String _parseDate(String strDate) {
  //           1
  // 0123456789012345678
  // 03-08-2019 11:59:15
  // 2019-09-03 11:78:87.3642864
  return strDate.substring(8,10) +
  "-" +
  strDate.substring(5,7) +
  "-" +
  strDate.substring(0,4);
  //" " +;
  //strDate.substring(11,19);

}

class CommonDateTimeDataentry extends StatefulWidget {
  ModoDataenry modo;
  String labelData;
  String labelHora;
  String initialDate;
  String strData;
  String strHora;

  CommonDateTimeDataentry({Key key, this.modo = ModoDataenry.linear, this.labelData = "Data", this.labelHora="Hora"}) : super(key: key);

  String getDateTimeDataentry(){
    return strData + " " + strHora;
  }

  void setDateTime(String strDateTime){
    initialDate = strDateTime;    
  }
  
  @override
  _CommonDateTimeDataentryState createState() => _CommonDateTimeDataentryState();
}

class _CommonDateTimeDataentryState extends State<CommonDateTimeDataentry> {

  // Define um atributo com a hora atual do dispositivo
  TimeOfDay _time = new TimeOfDay.now();

  // Controladores dos campos de data e hora
  TextEditingController tecdata = new TextEditingController();
  TextEditingController techora = new TextEditingController();

  Future<Null> _selectData(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 1)),
        lastDate: new DateTime.now().add(new Duration(days: 365))
    );
    if(picked != null) setState(() {
      tecdata.text = _parseDate(picked.toString());
      widget.strData = tecdata.text;
    } );
  }

  Future<Null> _selectHora(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time,
    );
    if(picked != null && picked != _time) setState(() {
      techora.text = picked.format(context);
      widget.strHora = techora.text + ":00";
    } );
  }

  @override
  void initState(){
    super.initState();
    if(widget.initialDate != null){
      tecdata.text = widget.initialDate.substring(0,10);
      techora.text = widget.initialDate.substring(11,19);
      widget.strData = tecdata.text;
      widget.strHora = techora.text;
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget _datawid = Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: TextField(
          onTap: (){_selectData(context);},
          controller: tecdata,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
                labelText: widget.labelData,
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder()
            ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0
        ),
      ),
    );

    Widget _horawid = Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
              onTap: (){_selectHora(context);},
              controller: techora,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    labelText: widget.labelHora,
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0
            ),
          ),
        );


    return Column(
      children: <Widget>[
        _datawid,
        _horawid
      ],
      
    );
  }
}