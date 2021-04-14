import 'package:flutter/material.dart';

class CommonAssetImageCircle extends StatelessWidget {

  double widthcic;
  double heightcic;
  double bordercic;
  Color bordercolorcic;
  String urlimage;

  CommonAssetImageCircle(this.urlimage,
      {this.widthcic=64.0, this.heightcic=64.0, this.bordercic=3.0, this.bordercolorcic=Colors.blueAccent}
      );

  @override
  Widget build(BuildContext context) {
    print("assets/images/" + urlimage);
    return Container(
        width: widthcic,
        height: heightcic,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: new Border.all(
              width: bordercic,
              color: bordercolorcic,
            ) ,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new AssetImage("assets/images/" + urlimage)
            )
        )
    );
  }
}
