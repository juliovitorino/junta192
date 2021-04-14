import 'package:flutter/material.dart';
import '../style/text_styles.dart';

class AdsGame extends StatelessWidget {

  final String imagePath;
  const AdsGame({Key key, @required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Stack(
        children: <Widget>[
// --- Imagem   
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.asset(imagePath,
                width: 90,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),

 // --- Botão posicionado sobreposicionado no fundo da imagem - PQP! que trabalho!
          Positioned(
            bottom: 4,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: (){},
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text("Play", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}