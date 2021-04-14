import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob-custom.dart';

class AdMobInterstitial<T> implements AdMobCustomFactory<T> {
  Completer<T> completer = Completer<T>();
  T _interstitial;

  @override
  T getBanner() {
    _interstitial = (InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$InterstitialAd loaded.');
          completer.complete(ad as T);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$InterstitialAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$InterstitialAd onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('$InterstitialAd onAdClosed.');
          ad.dispose();
        },
        onApplicationExit: (Ad ad) => print('$InterstitialAd onApplicationExit.'),
      ),
    )..load()) as T;

    return _interstitial;
  }

  @override
  Future<T> bannerLoad() async {
    return completer.future;
  }


}
