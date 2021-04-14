import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RatingIndicator extends StatelessWidget {
  int qtdStar1;
  int qtdStar2;
  int qtdStar3;
  int qtdStar4;
  int qtdStar5;
  int total;

  RatingIndicator(this.qtdStar1,this.qtdStar2,this.qtdStar3,this.qtdStar4,this.qtdStar5)
  {
    this.total = this.qtdStar1+this.qtdStar2+this.qtdStar3+this.qtdStar4+this.qtdStar5;
  }

  @override
  Widget build(BuildContext context) {

    double _percStar1 = total == 0 ? 0 : qtdStar1 / total;
    double _percStar2 = total == 0 ? 0 : qtdStar2 / total;
    double _percStar3 = total == 0 ? 0 : qtdStar3 / total;
    double _percStar4 = total == 0 ? 0 : qtdStar4 / total;
    double _percStar5 = total == 0 ? 0 : qtdStar5 / total;

    return new Container(
    child: Padding(
      padding: EdgeInsets.only(top:10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 120,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star)
                  ],
                )
              ),
              new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: _percStar1,
                center: Text(
                  (_percStar1*100).toStringAsFixed(1) + "%",
                  style: new TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                trailing: Icon(Icons.mood_bad),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey,
                progressColor: Colors.red,
              ),              
              Text("("+ qtdStar1.toString()+")"),

            ]
          ),
          Row(
            children: <Widget>[
              Container(
                width: 120,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Icon(Icons.star),
                  ],
                )
              ),
              new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: _percStar2,
                center: Text(
                  (_percStar2*100).toStringAsFixed(1) + "%",
                  style: new TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                trailing: Icon(Icons.mood_bad),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey,
                progressColor: Colors.red,
              ),              
              Text("("+ qtdStar2.toString()+")"),

            ]
          ),
          Row(
            children: <Widget>[
              Container(
                width: 120,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                  ],
                )
              ),
              new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: _percStar3,
                center: Text(
                  (_percStar3*100).toStringAsFixed(1) + "%",
                  style: new TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                trailing: Icon(Icons.mood),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey,
                progressColor: Colors.yellow,
              ),              
              Text("("+ qtdStar3.toString()+")"),

            ]
          ),
          Row(
            children: <Widget>[
              Container(
                width: 120,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                  ],
                )
              ),
              new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: _percStar4,
                center: Text(
                  (_percStar4*100).toStringAsFixed(1) + "%",
                  style: new TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                trailing: Icon(Icons.mood),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),              
              Text("("+ qtdStar4.toString()+")"),

            ]
          ),
          Row(
            children: <Widget>[
              Container(
                width: 120,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),

                  ],
                )
              ),
              new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: _percStar5,
                center: Text(
                  (_percStar5*100).toStringAsFixed(1) + "%",
                  style: new TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                trailing: Icon(Icons.mood),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),              
              Text("("+ qtdStar5.toString()+")"),

            ]
          ),

        ],
      ),
    )
  );
  }
}