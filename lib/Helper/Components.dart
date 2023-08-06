

import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/Helper/MethodsHelper.dart';
import 'package:nwayooknowledge/pages/readPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ConvertPref.dart';

class Components{
  String? finalimage;

  static Widget getimg(img) {
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

  static Widget getPostCardContainer(context, postData) {
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

                    var timeStamp = DateTime.now().millisecondsSinceEpoch;

                    var pointpref = await SharedPreferences.getInstance();
                    int i = pointpref.getInt('key') ?? 0;
                    pointpref.setInt('key', i + 1);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            viewPost(postDatabase: postData)));
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

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  static Widget getPointCard (context , point, click){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

          child: Card(
            elevation: 10,

            // color: Colors.blueGrey,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'My Points',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                  fontSize: 10),
                            ),
                          ),
                          Center(
                            child: Text(
                              // '${snapshot.data}',
                              point,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      )),
                ),

                Container(
                  width: 1,
                  height: 40,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                // Container(width: 1,height: 20,color: Colors.black,),
                Center(
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'Total Click',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                  fontSize: 10),
                            ),
                          ),
                          Center(
                            child: Text(
                              click,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )
      ),
    );
  }
  
  static Widget getStremWatch (){
    
    return StreamBuilder<int>(
      stream: getStreamInt(),
      builder: (context,snapshot){

        if(snapshot.hasData){

          return   Center(
            child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        'My Points',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary,
                            fontSize: 10),
                      ),
                    ),
                    Center(
                      child: Text(
                        // '${snapshot.data}',
                        snapshot.data.toString(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary,
                            fontSize: 18),
                      ),
                    ),
                  ],
                )),
          );
        }else{

          return Text('data Error');
        }

      },

    );
  }

  static Stream<int> getStreamInt()async* {

    var pts = await MethodsHelper.getPtsFromSharePref();

    yield pts;

  }

  static Stream<int> getClickStreamInt()async* {

    var click = await MethodsHelper.getTotalClick();

    yield click;

  }
}
