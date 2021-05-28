import 'dart:io';

import 'admob-interstitial.dart';
import 'admob-banner.dart';

abstract class AdMobCustomFactory<T> {

  // Métodos implementados pelas heranças
  T getBanner(); 
  Future<T> bannerLoad();

  /// Retorna o BannerAdID da plataforma AdMob - blocos de anuncios
  static final String bannerAdUnitID = Platform.isIOS 
      ? 'ca-app-pub-1205119990657394/6362661313'
      : 'ca-app-pub-1205119990657394/6004189813';

  static final String interstitialAdUnitID = Platform.isIOS 
      ? 'ca-app-pub-1205119990657394/1820781071'
      : 'ca-app-pub-1205119990657394/7729524391';
  
  static final String rewardAdUnitID = Platform.isIOS 
      ? 'ca-app-pub-1205119990657394/6662044214'
      : 'ca-app-pub-1205119990657394/3604991255';
  
  // 
  // Métodos implementados dentro da classe
  // 
    
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