import 'package:flutter/material.dart';
import 'dart:async';

class CommonShowDialogYesNo extends Dialog {

  String msg;
  Icon icon;
  String textYes;
  String textNo;
  BuildContext context;
  String choice;

  CommonShowDialogYesNo({Key key, 
  @required this.context, 
  @required this.icon, 
  @required this.msg, 
  this.textYes='OK', 
  this.textNo}) : super(key: key);

  String getChoice(){
    return choice;
  }

  Future showDialogYesNo() async {

    List<Widget> lstSimpleDialogOption = [];
    lstSimpleDialogOption.add(new SimpleDialogOption(
                                  onPressed: (){
                                    Navigator.pop(context); 
                                    choice='Y';
                                  },
                                  child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                          Text(textYes, textAlign: TextAlign.right, 
                                              style: TextStyle(fontSize: 18.0,color: Colors.blue, fontWeight: FontWeight.bold),)
                                      ]
                                    )
                              )
    );

    if(textNo != null){
      lstSimpleDialogOption.add(new SimpleDialogOption(
                                    onPressed: (){
                                      Navigator.pop(context); 
                                      choice='N';
                                    },
                                    child: new Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(textNo, textAlign: TextAlign.right, 
                                              style: TextStyle(fontSize: 18.0,color: Colors.blue, fontWeight: FontWeight.bold),)
                                        ]
                                      )
                                )
      );
  
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
            child: Text(msg),
          ),
          actions: <Widget>[
            new SimpleDialogOption(
                                  onPressed: (){
                                    Navigator.pop(context); 
                                    choice='Y';
                                  },
                                  child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                          Text(textYes, textAlign: TextAlign.right, 
                                              style: TextStyle(fontSize: 18.0,color: Colors.blue, fontWeight: FontWeight.bold),)
                                      ]
                                    )
                              ),
            new SimpleDialogOption(
                                    onPressed: (){
                                      Navigator.pop(context); 
                                      choice='N';
                                    },
                                    child: new Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(textNo, textAlign: TextAlign.right, 
                                              style: TextStyle(fontSize: 18.0,color: Colors.blue, fontWeight: FontWeight.bold),)
                                        ]
                                      )
                                )
          ],
        );
      }
    );


/*
    return showDialog(
              context: context,
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    new SimpleDialog(
                      title: new Text(msg),
                      children: lstSimpleDialogOption,
                    ) 
                  ],
                ),
              )
            );

  */
  }


}