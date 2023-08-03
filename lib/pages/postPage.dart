import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nwayooknowledge/Helper/BannerAdsHelper.dart';
import 'package:nwayooknowledge/Modal/postmodal.dart';
import 'package:nwayooknowledge/pages/readPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api.dart';
import '../Helper/Components.dart';
import '../Helper/ConstsData.dart';
import '../Helper/ConvertPref.dart';
import '../utils.dart';
const _APP_USER_ID = 'some-unique-app-user-id-123';
class MyPostPage extends StatefulWidget {

  const MyPostPage({super.key});

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage>  with IronSourceBannerListener ,IronSourceImpressionDataListener, IronSourceInitializationListener ,IronSourceRewardedVideoManualListener {

  late MyPostModal myPostModal;
  bool _isRewardedVideoAvailable = false;
  bool _isVideoAdVisible = false;
  IronSourceRewardedVideoPlacement? _placement;
  @override
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((_)
    {
      initIronSource().then((value){
        IronSource.setBannerListener(this);

        IronSource.setManualLoadRewardedVideo(this);

        IronSource.loadRewardedVideo();

        bannerLoad();
      }
      );
    });




    super.initState();
  }

  void goReadPage(postData) async{

    var timeStamp = DateTime.now().millisecondsSinceEpoch;

    var pointpref = await SharedPreferences.getInstance();
    int i = pointpref.getInt('key') ?? 0;
    pointpref.setInt('key', i + 1);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            viewPost(postDatabase: postData)));
  }

  void CheckRewardAds(){



   if(_isRewardedVideoAvailable){

     print('RewReady');
     IronSource.showRewardedVideo();
   }else{

     print('checkRewardsLoading');
     IronSource.loadRewardedVideo();
   }


    //
    // setState(() {
    //
    // });
  }

  void showRewardAds(){
    _isRewardedVideoAvailable
        ? () async {
      // checkRVPlacement();
      if (await IronSource.isRewardedVideoAvailable()) {
        // for the RV server-to-server callback param
        // await IronSource.setDynamicUserId('some-dynamic-user-id');

        // for placement capping test
        // IronSource.showRewardedVideo(placementName: 'CAPPED_PLACEMENT');
        IronSource.showRewardedVideo();

        // onRewardedVideoAvailabilityChanged(false) won't be called on show
        // So, the state must be changed manually.
        setState(() {
          _isRewardedVideoAvailable = false;
        });
      }
    }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: FutureBuilder(


        future: Api.getMyPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return Container(
              margin: EdgeInsets.only(top: 70),
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return getPostCardContainer(
                        context, snapshot.data![index]);

                        
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
        },
      ),
    );
  }

  Widget myimg(MyPostModal postDatabase) {
    return Image.network(postDatabase.image);
  }
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
          verticalOffset: 120,);
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

  String? finalimage;

   Widget getimg(img) {
    try {
      return Image.network(
        img,

        width: 100,
        height: 100,
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.network(
        ConstsData.temporaryimg,
        width: 100,
        height: 100,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              value: loadingProgress.expectedTotalBytes !=
                  null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },

      );
    }
  }

   Widget getPostCardContainer(context, postData,) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Container(
            height: 170,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              // color: Theme.of(context).colorScheme.onBackground,
              elevation: 5,
              // shadowColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: InkWell(
                  onTap: ()  {

                    myPostModal = postData;



                    CheckRewardAds();


                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        getimg(
                          postData.image,

                        ),
                        // Image.network(
                        //   postData.image,
                        //   width: 100,
                        //   height: 100,
                        //   fit: BoxFit.fill,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  Convert_Pref.readTimestamp(
                                      int.parse(postData.timeStamp)),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  maxLines: 3,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),


                                child: Row(

                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          postData.mmtitle,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),

                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.blueGrey,

                                          ),
                                          child: Text(
                                            'Author : : ${postData.author}',
                                            style: const TextStyle(
                                                fontSize: 10, color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          // color: Colors.blue,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.blueGrey,
                                          ),
                                          child: Text(
                                            'Source : : ${postData.source}',
                                            style: const TextStyle(
                                                fontSize: 10, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  child: Text(
                                    postData.mmcontent,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    maxLines: 3,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  @override

  // RewardedVideo Manual Load listener
  @override
  void onRewardedVideoAdClicked(IronSourceRewardedVideoPlacement placement) {
    print('onRewardedVideoAdClicked Placement:$placement');
  }

  @override
  void onRewardedVideoAdClosed() {
    print("onRewardedVideoAdClosed");
    setState(() {
      _isVideoAdVisible = false;
    });
    if (mounted && _placement != null && !_isVideoAdVisible) {

      goReadPage( myPostModal);
      setState(() {
        _placement = null;
      });
    }
  }

  @override
  void onRewardedVideoAdEnded() {
    print("onRewardedVideoAdClosed");
  }

  @override
  void onRewardedVideoAdOpened() {
    print("onRewardedVideoAdOpened");
    if (mounted) {
      setState(() {
        _isVideoAdVisible = true;
      });
    }
  }

  @override
  void onRewardedVideoAdRewarded(IronSourceRewardedVideoPlacement placement) {
    print("onRewardedVideoAdRewarded Placement: $placement");
    setState(() {
      _placement = placement;
    });
    if (mounted && _placement != null && !_isVideoAdVisible) {
      Utils.showTextDialog(
          context, 'Video Reward', _placement?.toString() ?? '');
      setState(() {
        _placement = null;
      });
    }
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    print("onRewardedVideoAdShowFailed Error:$error");
    if (mounted) {
      setState(() {
        _isVideoAdVisible = false;
      });
    }
  }

  @override
  void onRewardedVideoAdStarted() {
    print("onRewardedVideoAdStarted");
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool isAvailable) {
    print('onRewardedVideoAvailabilityChanged: $isAvailable');
    if (mounted) {
      setState(() {
        _isRewardedVideoAvailable = isAvailable;
      });
    }
  }

  @override
  void onRewardedVideoAdReady() {
    print('onRewardedVideoAdReady');
    if (mounted) {
      setState(() {
        _isRewardedVideoAvailable = true;

      });
    }
  }

  @override
  void onRewardedVideoAdLoadFailed(IronSourceError error) {
    print("onRewardedVideoAdShowFailed Error:$error");
    if (mounted) {
      setState(() {
        _isRewardedVideoAvailable = false;
      });
    }
  }
  Future<void> setRewardedVideoCustomParams() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    await IronSource.setRewardedVideoServerParams({'dateTimeMillSec': time});
    Utils.showTextDialog(context, "RV Custom Param Set", time);
  }

  // Solely for debug/testing purpose
  Future<void> checkRewardedVideoPlacement() async {
    final placement = await IronSource.getRewardedVideoPlacementInfo(
        placementName: 'DefaultRewardedVideo');
    print('DefaultRewardedVideo info $placement');

    // this falls back to the default placement, not null
    final noSuchPlacement =
    await IronSource.getRewardedVideoPlacementInfo(placementName: 'NoSuch');
    print('NoSuchPlacement info $noSuchPlacement');

    final isPlacementCapped = await IronSource.isRewardedVideoPlacementCapped(
        placementName: 'CAPPED_PLACEMENT');
    print('CAPPED_PLACEMENT isPlacementCapped: $isPlacementCapped');
  }
}
