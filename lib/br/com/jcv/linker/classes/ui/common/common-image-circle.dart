import 'package:flutter/material.dart';

class CommonImageCircle extends StatelessWidget {

  double widthcic;
  double heightcic;
  double bordercic;
  Color bordercolorcic;
  String urlimage;

  CommonImageCircle(this.urlimage,
      {this.widthcic=64.0, this.heightcic=64.0, this.bordercic=3.0, this.bordercolorcic=Colors.blueAccent}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widthcic,
        height: heightcic,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
              width: bordercic,
              color: bordercolorcic,
            ) ,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: urlimage != "no-user.png"
                    ? new NetworkImage(urlimage)
                    : new AssetImage("assets/images/" + urlimage)
            )
        )
    );
  }
}
