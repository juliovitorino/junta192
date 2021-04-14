import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admob-interstitial.dart';
import 'admob-banner.dart';

abstract class AdMobCustomFactory<T> {

  // Métodos implementados pelas heranças
  T getBanner(); 
  Future<T> bannerLoad();
  
  // 
  // Métodos implementados dentro da classe
  // 
  String get _testBannerAdUnitID => BannerAd.testAdUnitId;
  //String get _testInterstitialAdUnitID => InterstitialAd.testAdUnitId;
  
  /// Retorna o BannerAdID da plataforma AdMob - blocos de anuncios
  String get _bannerAdUnitID => Platform.isIOS 
    ? '<pegar-codigo-na-plataforma-AdMob>'
    : 'ca-app-pub-1205119990657394/6004189813';

  String get _interstitialAdUnitID => Platform.isIOS 
    ? '<pegar-codigo-na-plataforma-AdMob>'
    : 'ca-app-pub-1205119990657394/7729524391';

  factory AdMobCustomFactory(String tipo) {
    switch (tipo) {
      case 'BannerAd':
          return AdMobBanner();
        break;
      case 'interstitial':
          return AdMobInterstitial();
        break;
      default:
        return null;
    }
  }



}