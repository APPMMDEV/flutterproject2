import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/Pages/readPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ConvertPref.dart';

class Components {
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
      );
    }
  }

  static Widget getPostCardContainer(context, postData) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Container(
            height: 150,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).colorScheme.onBackground,
              elevation: 5,
              shadowColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: InkWell(
                  onTap: () async {
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

                        getimg( postData.image,),
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
                                alignment: Alignment.topRight,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      // color: Colors.blue,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        'Author : : ${postData.author}',
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      // color: Colors.blue,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        'Source : : ${postData.source}',
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  postData.mmtitle,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
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
}