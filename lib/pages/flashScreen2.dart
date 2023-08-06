import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/pages/postPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api.dart';
import '../Helper/ConvertPref.dart';
import '../Modal/postmodal.dart';
import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';
import 'ProfilePage.dart';
import 'readPost.dart';

class FlashScreen2 extends StatefulWidget {
  const FlashScreen2({super.key});

  @override
  State<FlashScreen2> createState() => _FlashScreen2State();
}

class _FlashScreen2State extends State<FlashScreen2> {
  int currentIndex = 0;
  var pts = '0 pts';
  var tclick = 'o click';

  late MyPostModal myPostModal;

  bool _switch = false;
  ThemeData _dark = darkTheme;
  ThemeData _light = lightTheme;

  var darkicon = Icons.dark_mode;
  var lighticon = Icons.light_mode;

  void getPtsFromSharePref() async {
    var pointpref = await SharedPreferences.getInstance();
    int i = pointpref.getInt('key') ?? 0;

    setState(() {
      pts = i.toString();
    });
  }

  void getTotalClick() async {
    var totalpointPref = await SharedPreferences.getInstance();
    int j = totalpointPref.getInt('total') ?? 0;

    setState(() {
      tclick = j.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _switch ? _dark : _light,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              ConstsData.app_name,

            ),

            elevation: 0,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.light_mode_rounded),
                    Switch(
                        value: _switch,
                        onChanged: (_newvalue) {
                          setState(() {
                            _switch = _newvalue;
                          });
                        }),
                    const Icon(Icons.dark_mode_rounded)
                  ],
                ),
              ),

              IconButton(onPressed: (){

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  MyProfile()));


              }, icon: Icon(Icons.person))
            ],
          ),
          body: getScreen(),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [

              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )
      ),
    );
  }



  // Widget getScreen(){
  //   var screens = [ postWidget(), profileWidget()];
  //
  //   var screens = [const MyPostPage(),const MyProfile()];
  //   return IndexedStack(children: screens,
  //     index: currentIndex,);
  // }

  Widget getScreen() {
    var screens = [ postWidget(), profileWidget()];
    return screens[currentIndex];
  }
Widget postWidget(){

    return FutureBuilder(


      future: Api.getMyPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return Container(
            margin: const EdgeInsets.only(bottom: 70),
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
    );
}

  Widget myimg(MyPostModal postDatabase) {
    return Image.network(postDatabase.image);
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
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Container(
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
                  onTap: ()  {

                    myPostModal = postData;


                    // CheckRewardAds();
                    // showRewardAds();
                    setTotalClickPoint();
                    setSuccessPoint();


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
                                margin: const EdgeInsets.only(left: 10),
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

  void setSuccessPoint() async{

    var pointpref = await SharedPreferences.getInstance();
    int i = pointpref.getInt('key') ?? 0;
    pointpref.setInt('key', i + 1);

    int t = pointpref.getInt('total') ?? 0;
    pointpref.setInt('total', t + 1);
  }

  void setTotalClickPoint() async{

    var tpf = await SharedPreferences.getInstance();
    int i = tpf.getInt('total') ?? 0;
    tpf.setInt('total', i + 1);


  }

  void goReadPage(postData,success) async{


    if(success){
      setSuccessPoint();

    }else{

      setTotalClickPoint();

    }





    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            viewPost(postDatabase: postData)));
  }
Widget profileWidget(){
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 30),
                    child: const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 85,
                        child: CircleAvatar(
                            radius: 79,
                            backgroundImage:
                            AssetImage('assets/images/logo.png')),
                      ),
                    ),
                  ),
                  const Text(ConstsData.app_name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          // color: Colors.blueGrey,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                    margin: EdgeInsets.symmetric(
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
                                            pts,
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
                                    margin: EdgeInsets.symmetric(
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
                                            tclick,
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
                  ),
                ],
              ),
            ),
          ],
        ));
}
}
