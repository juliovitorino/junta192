import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob-custom.dart';

class AdMobBanner<T> implements AdMobCustomFactory<T> {
  Completer<T> completer = Completer<T>();
  T _bannerad;

  @override
  T getBanner() {
    _bannerad = (BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          completer.complete(ad as T);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$BannerAd onApplicationExit.'),
      ),
    )..load()) as T;

    return _bannerad;
  }

  @override
  Future<T> bannerLoad() async {
    return completer.future;
  }


}
