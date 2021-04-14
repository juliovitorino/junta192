import 'package:flutter/material.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-dataitem-title-text.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-actionbutton.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:junta192/br/com/jcv/linker/classes/ui/rating/rating-indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:junta192/br/com/jcv/linker/classes/campanha/campanhaComentariosPage.dart';


class ChartDataModel {
  final String label;
  final int val;
  final charts.Color color;

  ChartDataModel(this.label, this.val, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class ChartDataModelFloat {
  final String label;
  final double val;
  final charts.Color color;

  ChartDataModelFloat(this.label, this.val, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}


class CampanhaPerformanceDetail extends StatelessWidget {

  dynamic _cartaofull;

  CampanhaPerformanceDetail(this._cartaofull);


  @override
  Widget build(BuildContext context) {

    // --- chart de cartoes
    var dataCartao = [
      new ChartDataModel('Cartões',_cartaofull['maximoCartoes'], Colors.red),
      new ChartDataModel('Distribuídos',_cartaofull['contadorCartoes'], Colors.yellow),
    ];

    var seriesCartao = [
      new charts.Series(
        domainFn: (ChartDataModel clickData, _) => clickData.label,
        measureFn: (ChartDataModel clickData, _) => clickData.val,
        colorFn: (ChartDataModel clickData, _) => clickData.color,
        id: 'chartCartao',
        data: dataCartao,
      ),
    ];

    var chartCartao = new charts.BarChart(
      seriesCartao,
      animate: true,
    );

    var chartCartaoWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chartCartao,
      ),
    );

    double _percmetaCartao = 0;
    if(_cartaofull['maximoCartoes'] == 0){
      _percmetaCartao = 0;
    } else {
      _percmetaCartao = _cartaofull['contadorCartoes']/_cartaofull['maximoCartoes'];
    }
    double _percmetaCartao100 = _percmetaCartao * 100;


    //-- chart de carimbos
    var dataCarimbo = [
      new ChartDataModel('Carimbos',int.parse(_cartaofull['totalCarimbos']), Colors.blue),
      new ChartDataModel('Distribuídos',int.parse(_cartaofull['totalCarimbados']), Colors.yellow),
    ];

    var seriesCarimbo = [
      new charts.Series(
        domainFn: (ChartDataModel clickData, _) => clickData.label,
        measureFn: (ChartDataModel clickData, _) => clickData.val,
        colorFn: (ChartDataModel clickData, _) => clickData.color,
        id: 'chartCarimbo',
        data: dataCarimbo,
      ),
    ];

    var chartCarimbo = new charts.BarChart(
      seriesCarimbo,
      animate: true,
    );

    var chartCarimboWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chartCarimbo,
      ),
    );

    double _percmetaCarimbo = 0;
    if(_cartaofull['totalCarimbados'] == 0){
      _percmetaCarimbo = 0;
    } else {
      _percmetaCarimbo = int.parse(_cartaofull['totalCarimbados'])/int.parse(_cartaofull['totalCarimbos']);
    }
    double _percmetaCarimbo100 = _percmetaCarimbo * 100;
    int _totalClientes = _cartaofull['contadorStar_1'] +
        _cartaofull['contadorStar_2'] +
        _cartaofull['contadorStar_3'] +
        _cartaofull['contadorStar_4'] +
        _cartaofull['contadorStar_5'];

    //-- chart de desempenho financeiro
    double _metaFinanceira = int.parse(_cartaofull['totalCarimbos']) * _cartaofull['valorTicketMedioCarimbo'].toDouble();
    var dataFinanceiro = [
      new ChartDataModelFloat('Previsto',_metaFinanceira, Colors.blue),
      new ChartDataModelFloat('Realizado',_cartaofull['valorAcmTicketMedio'].toDouble(), Colors.yellow),
    ];

    var seriesFinanceiro = [
      new charts.Series(
        domainFn: (ChartDataModelFloat clickData, _) => clickData.label,
        measureFn: (ChartDataModelFloat clickData, _) => clickData.val,
        colorFn: (ChartDataModelFloat clickData, _) => clickData.color,
        id: 'chartFinanceiro',
        data: dataFinanceiro,
      ),
    ];

    var chartFinanceiro = new charts.BarChart(
      seriesFinanceiro,
      animate: true,
    );

    var chartFinanceiroWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chartFinanceiro,
      ),
    );

    double _percmetaFinanceiro = 0;
    if(_cartaofull['valorTicketMedioCarimbo'] == 0){
      _percmetaFinanceiro = 0;
    } else {
      _percmetaFinanceiro = _cartaofull['valorAcmTicketMedio']/ _metaFinanceira;
    }
    double _percmetaFinanceiro100 = _percmetaFinanceiro*100;

    // Chart de satisfação
    var dataSatisfacao = [
      new ChartDataModel('Péssimo',_cartaofull['contadorStar_1'], Colors.red),
      new ChartDataModel('Ruim',_cartaofull['contadorStar_2'], Colors.redAccent),
      new ChartDataModel('Bom',_cartaofull['contadorStar_3'], Colors.yellow),
      new ChartDataModel('Ótimo',_cartaofull['contadorStar_4'], Colors.blueAccent),
      new ChartDataModel('Excelente',_cartaofull['contadorStar_5'], Colors.yellow),
    ];

    var seriesSatisfacao = [
      new charts.Series(
        domainFn: (ChartDataModel clickData, _) => clickData.label,
        measureFn: (ChartDataModel clickData, _) => clickData.val,
        colorFn: (ChartDataModel clickData, _) => clickData.color,
        id: 'chartSatisfacao',
        data: dataSatisfacao,
      ),
    ];

    var chartSatisfacao = new charts.BarChart(
      seriesSatisfacao,
      animate: true,
    );

    var chartSatisfacaoWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chartSatisfacao,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          new CommonDataItemTitleText("Campanha",_cartaofull['nome'] ),
          new CommonDataItemTitleText("Recompensa",_cartaofull['recompensa'] ),

          // Avaliação Geral
          new Center(child:
            new Column(
              children: <Widget>[
                new Text("Avaliação Geral", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                new SizedBox(height: 10.0,),
                Center(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Text("Clientes", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            new Icon(Icons.person, size:60.0, color: Colors.blue),
                            new Text(_totalClientes.toString(), style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            new Text("Nota", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            new Icon(Icons.star, size:60.0, color: Colors.amber),
                            new Text(_cartaofull['ratingCalculado'].toString(), style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            new Text("Curtidas", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            new Icon(Icons.thumb_up, size:60.0, color: Colors.blue),
                            new Text(_cartaofull['contadorLike'].toString(), style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                          ],
                        ),

                      ],
                    )
                )
              ]
            )
          ),

          // Satisfação dos clientes
          SizedBox(height: 20.0,),
          new Center(child:
          new Text("Nível de Satisfação de cartões", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          chartSatisfacaoWidget,
          SizedBox(height: 20.0,),

          // Avaliação dos clientes
          new SizedBox(height: 10.0,),
          new Center(child:
          new Text("Avaliação dos Clientes", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          new RatingIndicator(_cartaofull['contadorStar_1'],
              _cartaofull['contadorStar_2'],
              _cartaofull['contadorStar_3'],
              _cartaofull['contadorStar_4'],
              _cartaofull['contadorStar_5']
          ),
          SizedBox(height: 10.0,),
          CommomActionButton(titulo: "Ver comentários", onpressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new CampanhaComentariosPage(_cartaofull, isShowImage: true,)));
          }),
          SizedBox(height: 30.0,),
          Divider(),
          // ==================================
          // Medidor de Desempenho
          // ==================================
          new Center(child:
          new Text("Medidor de Desempenho", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
          ),

          // desempenho financeiro
          SizedBox(height: 30.0,),
          new Center(child:
          new Text("Desempenho Financeiro", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10.0,),
          new CommonDataItemTitleText("Valor do Ticket Médio",_cartaofull['valorTicketMedioCarimboMoeda'] ),
          new CommonDataItemTitleText("Meta Financeira da Campanha",_cartaofull['valorMetaMoeda'] ),
          Center(
            child: Column(
              children: <Widget>[
                new CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: _percmetaFinanceiro,
                  center: new Text(
                    _percmetaFinanceiro100.toStringAsFixed(1)+"%",
                    style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: new Text(
                    _cartaofull['valorAcmTicketMedioMoeda'],
                    style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                chartFinanceiroWidget,
              ],
            ),
          ),


          // Quantitativo de cartões
          Divider(),
          SizedBox(height: 30.0,),
          new Center(child:
          new Text("Desempenho Quantitativo", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 30.0,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: _percmetaCartao,
                      center: new Text(
                        _percmetaCartao100.toStringAsFixed(1)+"%",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "Meta Cartões",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                    new Text(
                      _cartaofull['contadorCartoes'].toString() + "/" + _cartaofull['maximoCartoes'].toString() ,
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),

                  ],
                ),
                SizedBox(width: 40.0,),
                Column(
                  children: <Widget>[
                    new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: _percmetaCarimbo,
                      center: new Text(
                        _percmetaCarimbo100.toStringAsFixed(1)+"%",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "Meta Carimbos",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                    new Text(
                      _cartaofull['totalCarimbados'] + "/" + _cartaofull['totalCarimbos'],
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),

                  ],
                )
              ]
          ),

          SizedBox(height: 20.0,),
          new Center(child:
          new Text("Distribuição de cartões", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          chartCartaoWidget,
          SizedBox(height: 20.0,),
          new Center(child:
          new Text("Aplicação de carimbos", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          chartCarimboWidget,
        ],
      ),
    );
  }
}