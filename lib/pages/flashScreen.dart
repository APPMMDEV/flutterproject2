import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/pages/postPage.dart';

import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';
import 'ProfilePage.dart';

const _APP_USER_ID = 'some-unique-app-user-id-123';
class FlashScreen extends StatefulWidget {

  final PointDAO pointDAO;
  const FlashScreen({super.key,required this.pointDAO});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}


class _FlashScreenState extends State<FlashScreen> with IronSourceBannerListener ,IronSourceImpressionDataListener, IronSourceInitializationListener {

  int currentIndex = 0;

  bool _switch = false;
  ThemeData _dark = darkTheme;
  ThemeData _light = lightTheme;

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
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((_)
    {
      initIronSource().then((value){
        IronSource.setBannerListener(this);
        bannerLoad();
      }
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: _switch ? _dark : _light,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Nway Oo Knowledge',
            ),
            elevation: 0,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Switch(
                        value: _switch,
                        onChanged: (_newvalue) {
                          setState(() {
                            _switch = _newvalue;
                          });
                        }),
                    const Text('Dark Mode')
                  ],
                ),
              )
            ],
          ),
          body: getScreen(),

          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),);
  }

  Widget getScreen(){
  var screens = [MyPostPage(pointDAO: widget.pointDAO,),MyProfile(pointDAO: widget.pointDAO)];
    return Container(

      child: screens[currentIndex],
      );
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
