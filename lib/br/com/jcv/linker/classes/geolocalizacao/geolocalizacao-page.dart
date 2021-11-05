import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocalizacaoPage extends StatefulWidget {
  
  GeoLocalizacaoPage({
    Key key,
  }) : super(key: key);


  @override
  _GeoLocalizacaoPageState createState() => _GeoLocalizacaoPageState();
}

class _GeoLocalizacaoPageState extends State<GeoLocalizacaoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onde tem Junta10"),
      ),
      body: GoogleMap(initialCameraPosition: CameraPosition(
        target: LatLng(-22.0,-44.12),
        zoom: 18,
      ),),
    );
  }
}