import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';

const _APP_USER_ID = 'some-unique-app-user-id-123';
class BannerAdsHelper with IronSourceBannerListener ,IronSourceImpressionDataListener, IronSourceInitializationListener {

   void bannerLoad() async{

    final isCapped =
    await IronSource.isBannerPlacementCapped('DefaultBanner');
    print('Banner DefaultBanner capped: $isCapped');
    if (!isCapped) {
      final size = IronSourceBannerSize.BANNER;
      // size.isAdaptive = true; // Adaptive Banner
      IronSource.loadBanner(
          size: size,
          position: IronSourceBannerPosition.Top,
          verticalOffset: -50,
          placementName: 'DefaultBanner');
    }
  }
    Future<void> checkATT() async {
    final currentStatus =
    await ATTrackingManager.getTrackingAuthorizationStatus();
    print('ATTStatus: $currentStatus');
    if (currentStatus == ATTStatus.NotDetermined) {
      final returnedStatus =
      await ATTrackingManager.requestTrackingAuthorization();
      print('ATTStatus returned: $returnedStatus');
    }
    return;
  }



   Future<void> enableDebug() async {
    await IronSource.setAdaptersDebug(true);
    // this function doesn't have to be awaited
    IronSource.validateIntegration();
  }

// Sample Segment Params
   Future<void> setSegment() {
    final segment = IronSourceSegment();
    segment.age = 20;
    segment.gender = IronSourceUserGender.Female;
    segment.level = 3;
    segment.isPaying = false;
    segment.userCreationDateInMillis = DateTime.now().millisecondsSinceEpoch;
    segment.iapTotal = 1000;
    segment.setCustom(key: 'DemoCustomKey', value: 'DemoCustomVal');
    return IronSource.setSegment(segment);
  }

   Future<void> setRegulationParams() async {
    // GDPR
    await IronSource.setConsent(true);
    await IronSource.setMetaData({
      // CCPA
      'do_not_sell': ['false'],
      // COPPA
      'is_child_directed': ['false'],
      'is_test_suite': ['enable']
    });

    return;
  }



   Future<void> initIronSource() async {
    final appKey = Platform.isAndroid
        ? "85460dcd"
        : Platform.isIOS
        ? "8545d445"
        : throw Exception("Unsupported Platform");
    try {
      IronSource.setFlutterVersion('3.3.0'); // fetch automatically
      IronSource.setImpressionDataListener(this);
      await enableDebug();
      await IronSource.shouldTrackNetworkState(true);

      // GDPR, CCPA, COPPA etc
      await setRegulationParams();

      // Segment info
      // await setSegment();

      // For Offerwall
      // Must be called before init
      // await IronSource.setClientSideCallbacks(true);

      // GAID, IDFA, IDFV
      String id = await IronSource.getAdvertiserId();
      print('AdvertiserID: $id');

      // Do not use AdvertiserID for this.
      await IronSource.setUserId(_APP_USER_ID);

      // Authorization Request for IDFA use
      if (Platform.isIOS) {
        await checkATT();
      }

      // Finally, initialize
      await IronSource.init(
          appKey: appKey,
          adUnits: [
            IronSourceAdUnit.RewardedVideo,
            IronSourceAdUnit.Interstitial,
            IronSourceAdUnit.Banner,
            IronSourceAdUnit.Offerwall
          ],
          initListener: this);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void onBannerAdClicked() {
    // TODO: implement onBannerAdClicked
  }

  @override
  void onBannerAdLeftApplication() {
    // TODO: implement onBannerAdLeftApplication
  }

  @override
  void onBannerAdLoadFailed(IronSourceError error) {
    // TODO: implement onBannerAdLoadFailed
  }

  @override
  void onBannerAdLoaded() {
    // TODO: implement onBannerAdLoaded
  }

  @override
  void onBannerAdScreenDismissed() {
    // TODO: implement onBannerAdScreenDismissed
  }

  @override
  void onBannerAdScreenPresented() {
    // TODO: implement onBannerAdScreenPresented
  }

  @override
  void onImpressionSuccess(IronSourceImpressionData? impressionData) {
    // TODO: implement onImpressionSuccess
  }

  @override
  void onInitializationComplete() {
    // TODO: implement onInitializationComplete
  }


}