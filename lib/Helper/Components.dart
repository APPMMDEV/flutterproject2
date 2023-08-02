import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/Database/pointTable.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
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
      );
    }
  }

  static Widget getPostCardContainer(context, postData,PointDAO pointDAO) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Container(
            height: 170,
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



                    var timeStamp = DateTime.now().millisecondsSinceEpoch;



                    await pointDAO.addPoint(new PointData(1, 1));
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
  static Widget getPtsData(context, PointData pointData) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Container(
            height: 170,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).colorScheme.onBackground,
              elevation: 5,
              shadowColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: InkWell(

                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                    pointData.timeStamp.toString(),
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
                                          pointData.id.toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  child: Text(
                                    pointData.point.toString(),
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
