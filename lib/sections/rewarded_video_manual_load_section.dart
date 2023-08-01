import 'package:flutter/material.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import '../utils.dart';
import '../widgets/horizontal_buttons.dart';

class RewardedVideoManualLoadSection extends StatefulWidget {
  const RewardedVideoManualLoadSection({Key? key}) : super(key: key);

  @override
  _RewardedVideoManualLoadSectionState createState() =>
      _RewardedVideoManualLoadSectionState();
}

class _RewardedVideoManualLoadSectionState
    extends State<RewardedVideoManualLoadSection>
    with IronSourceRewardedVideoManualListener {
  bool _isRewardedVideoAvailable = false;
  bool _isVideoAdVisible = false;
  IronSourceRewardedVideoPlacement? _placement;

  @override
  void initState() {
    super.initState();
    IronSource.setManualLoadRewardedVideo(this);
  }

  // Sample RewardedVideo Custom Params - current DateTime milliseconds
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Rewarded Video", style: Utils.headingStyle),
      HorizontalButtons([
        ButtonInfo(
            "Load RewardedVideo",
            !_isRewardedVideoAvailable
                ? () {
                    IronSource.loadRewardedVideo();
                  }
                : null),
        ButtonInfo(
            "Show RewardedVideo",
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
                : null),
      ]),

    ]);
  }

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
      Utils.showTextDialog(
          context, 'Video Reward', _placement?.toString() ?? '');
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
}
