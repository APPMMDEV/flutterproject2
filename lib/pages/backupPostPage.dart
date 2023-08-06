import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nwayooknowledge/Helper/Components.dart';
import 'package:nwayooknowledge/Helper/MethodsHelper.dart';

import 'package:nwayooknowledge/Modal/postmodal.dart';
import 'package:nwayooknowledge/pages/readPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api.dart';

import '../Helper/ConvertPref.dart';
import '../utils.dart';


class BackupPostPage extends StatefulWidget {
  const BackupPostPage({super.key});

  @override
  State<BackupPostPage> createState() => _BackupPostPageState();
}

class _BackupPostPageState extends State<BackupPostPage> with IronSourceRewardedVideoListener{

  late MyPostModal currentPostModal;
  @override
  void initState() {

    IronSource.setRewardedVideoListener(this);
    super.initState();
  }

  void goReadPage(postData, success) async {


    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => viewPost(postDatabase: postData, AdsSuccess: success)));
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
              margin: const EdgeInsets.only(bottom: 70),
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    
                    currentPostModal = snapshot.data![index];
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



  String? finalimage;

  Widget getimg(img) {
    return Image.network(
      img,
      width: 100,
      height: 100,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        // return const Icon(Icons.error);
        return Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        );
      },
    );
  }

  @override
  void onRewardedVideoAdClicked(IronSourceRewardedVideoPlacement placement) {
    // TODO: implement onRewardedVideoAdClicked
  }

  @override
  void onRewardedVideoAdClosed() {

    _addPoint();
    
    goReadPage(currentPostModal, true);
    

    // TODO: implement onRewardedVideoAdClosed
  }

  static void _addPoint() async{
    var timeStamp = DateTime.now().millisecondsSinceEpoch;

    var pointpref = await SharedPreferences.getInstance();
    int i = pointpref.getInt('key') ?? 0;
    pointpref.setInt('key', i + 1);

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) =>
    //         viewPost(postDatabase: myPostModal)));
  }
  
  
  @override
  void onRewardedVideoAdEnded() {
    // TODO: implement onRewardedVideoAdEnded
  }

  @override
  void onRewardedVideoAdOpened() {
    // TODO: implement onRewardedVideoAdOpened
  }

  @override
  void onRewardedVideoAdRewarded(IronSourceRewardedVideoPlacement placement) {
    // TODO: implement onRewardedVideoAdRewarded
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    // TODO: implement onRewardedVideoAdShowFailed
  }

  @override
  void onRewardedVideoAdStarted() {
    // TODO: implement onRewardedVideoAdStarted
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool isAvailable) {
    // TODO: implement onRewardedVideoAvailabilityChanged
  }


   Widget getPostCardContainer(context, postData) {


    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: SizedBox(
            height: 170,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              // color: Theme.of(context).colorScheme.onBackground,
              elevation: 5,
              // shadowColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: InkWell(
                  onTap: () async {

                    _showRewardedAd();


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
                                margin: const EdgeInsets.only(right: 10),
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
                                margin: const EdgeInsets.all(5),


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
                                          padding: const EdgeInsets.all(5),

                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.blueGrey,

                                          ),
                                          child: Text(
                                            'Author : : ${postData.author}',
                                            style: const TextStyle(
                                                fontSize: 10, color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          // color: Colors.blue,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0),
                                            borderRadius: const BorderRadius.all(
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


   void _showRewardedAd() async {
    bool isAvailable = await IronSource.isRewardedVideoAvailable();

    if (isAvailable) {
      IronSource.showRewardedVideo(placementName: "YOUR_PLACEMENT_NAME");
    } else {
      print("Rewarded ad is not available at the moment.");
    }
  }
}
