import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/model/modelAssistente.dart';

class CommonAssistente extends StatefulWidget {

  List<AssistenteModel> lst = [];

  @override
  _CommonAssistenteState createState() => _CommonAssistenteState();

///
/// addAssistentePageItem - Adiciona uma pagina ao array para uso no widget
/// 
/// @param pageitem
/// 
  void addAssistentePageItem(AssistenteModel pageItem){
    lst.add(pageItem);
  }
}

class _CommonAssistenteState extends State<CommonAssistente> {
  String _titulo;
  String _descricao;
  Image _img;
  int index = 0;

  @override
  void initState(){
      _titulo = widget.lst[0].titulo;
      _descricao = widget.lst[0].descricao;
      _img = widget.lst[0].islocal == true
            ? Image.asset(widget.lst[0].urlimg)
            : Image.network(widget.lst[0].urlimg);
  }

  _changePageBack() {
    if(index == 0){
      index = widget.lst.length;
    }
    setState(() {
      _titulo = widget.lst[--index].titulo;
      _descricao = widget.lst[index].descricao;
      _img = widget.lst[index].islocal == true
            ? Image.asset(widget.lst[index].urlimg)
            : Image.network(widget.lst[index].urlimg);
    });

  }


  _changePageItem() {
    if(index == (widget.lst.length-1)){
      index = -1;
    }
    setState(() {
      _titulo = widget.lst[++index].titulo;
      _descricao = widget.lst[index].descricao;
      _img = widget.lst[index].islocal == true
            ? Image.asset(widget.lst[index].urlimg)
            : Image.network(widget.lst[index].urlimg);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
//-------------------------------------------------
// Widget expandido o máximo possível para 
// apresentar a imagem, titulo e descrição
//-------------------------------------------------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: _img,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(_titulo, textAlign: TextAlign.center, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w900),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(_descricao, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0),),
              ),
            ],
          ),
        ),

//-------------------------------------------------
// Botão para controlar a movimentação das paginas
//-------------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              (index == (widget.lst.length-1) || index == 0)
              ? Container(height: 0, width: 0,)
              : TextButton(
                  onPressed: _changePageBack,
                  child: Text("ANTERIOR"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                  ),
                ),

              TextButton(
                onPressed: index == (widget.lst.length-1) ? (){
                  Navigator.of(context).pop();
                } : null,
                child: Text("ENTENDI"),
                style: ButtonStyle(
                  backgroundColor:  index == (widget.lst.length-1) 
                                    ? MaterialStateProperty.all<Color>(Colors.green)
                                    : MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),

              index == (widget.lst.length-1) 
              ? Container(height: 0, width: 0,)
              : TextButton(
                  onPressed: _changePageItem,
                  child: Text("PRÓXIMO"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                  ),
                ),

                 
            ],
          ),
        ),
      ],
      
    );
  }
}