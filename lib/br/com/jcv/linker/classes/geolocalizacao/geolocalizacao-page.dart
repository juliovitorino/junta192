import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junta192/br/com/jcv/linker/classes/storages/cacheSession.dart';
import 'package:junta192/br/com/jcv/linker/classes/ui/ads/ads-royal-typeOne.dart';

import 'package:junta192/br/com/jcv/linker/classes/ui/common/common-loading.dart';

//import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class GeoLocalizacaoPage extends StatefulWidget {
  
  GeoLocalizacaoPage({
    Key key,
  }) : super(key: key);


  @override
  _GeoLocalizacaoPageState createState() => _GeoLocalizacaoPageState();
}

class _GeoLocalizacaoPageState extends State<GeoLocalizacaoPage> {
  
  FutureBuilder<Set<Marker>> _gmaps;
  Set<Marker> markers = Set<Marker>();
  Position _poscorrente;
  String _token;
  String _urlControlador;


  @override
  _GeoLocalizacaoPageState initState(){
    _token = CacheSession().getSession()['tokenid'];
    _urlControlador = CacheSession().getSession()['urlControlador'];

  }


  Future<List> _listCampanhaSorteio() async {
    http.Response response;
    String _url = '${_urlControlador}appListarCampanhasGMaps.php?tokenid=$_token';

    debugPrint(_url);
    response = await http.get(Uri.parse(_url));
    return (json.decode(response.body));
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator().getCurrentPosition();
  }

  Future<Set<Marker>> _loadCampanhas(BuildContext context) async {
    _poscorrente = await _getCurrentLocation();
    List lstCampanhas = await _listCampanhaSorteio();

    lstCampanhas.forEach((campanhaItem) { 
      markers.add(
        Marker(
          markerId: MarkerId(campanhaItem['id']),
          position: LatLng(campanhaItem['latitude'], campanhaItem['longitude']),
          //icon:  bmpA,
          infoWindow: InfoWindow(
            title: campanhaItem['usuario']['apelido'],
            snippet: campanhaItem['nome']
          ),
          onTap: () {
            showModalBottomSheet(
              context: context, 
              builder: (context) =>  Container(
                            padding: new EdgeInsets.all(16.0),
                            child: new Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.thumb_up, color: Colors.blue),
                                        SizedBox(width: 5.0,),
                                        Text("5 pessoas curtiram a campanha" ),
                                      ],
                                    ),
                                  ),
                                  new AdsRoyalTypeOne(campanhaItem['id'],campanhaItem['img'],campanhaItem['usuario']['apelido'],  Text(campanhaItem['nome']), isGetImagem: true ),

                              ],
                            ),
                          ),
            );

          }

        )
      );

    });

    return markers;

  }

  @override
  Widget build(BuildContext context) {

    _gmaps = FutureBuilder(
      future: _loadCampanhas(context),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new CommonLoading();
            case ConnectionState.done:
              if(snapshot.hasError) {
              }
              if(snapshot.hasData){
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_poscorrente.latitude, _poscorrente.longitude),
                    zoom: 18.1521,
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  markers: markers,
                );
              }
              break;
            default:
              return new Container(height: 0.0,width: 0.0,);
          }
      });

    //_loadCampanhas();

    return Scaffold(
      appBar: AppBar(
        title: Text("Onde tem Junta10"),
      ),
      body: _gmaps,
    );
  }
}