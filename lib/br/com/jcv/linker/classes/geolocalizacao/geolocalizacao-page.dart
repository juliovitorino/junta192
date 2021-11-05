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
  

  Set<Marker> markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    markers.add(
      Marker(
        markerId: MarkerId("FAB J10-1"),
        position: LatLng(-22.53446525795224, -44.06438902006575),
      )
    );

    markers.add(
      Marker(
        markerId: MarkerId("FAB J10-2"),
        position: LatLng(-22.53358329358749, -44.063530713206966),
      )
    );

    markers.add(
      Marker(
        markerId: MarkerId("FAB J10-3"),
        position: LatLng(-22.532228129499877, -44.063401967178145),
      )
    );


    markers.add(
      Marker(
        markerId: MarkerId("FAB J10-4"),
        position: LatLng(-22.53517627570643, -44.06424954521665),
      )
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Onde tem Junta10"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-22.5323031,-44.0635294),
          zoom: 18.1521,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: markers,
      ),
    );
  }
}