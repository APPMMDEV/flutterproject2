import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nwayooknowledge/Test/mytestpage.dart';


import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';
import '../Helper/ConstsData.dart';
import '../pages/ProfilePage.dart';
import '../pages/postPage2.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _switch = false;
  final ThemeData _dark = darkTheme;
  final ThemeData _light = lightTheme;
  int _currentIndex = 0;
  var darkicon = Icons.dark_mode;
  var lighticon = Icons.light_mode;


  @override
  void initState() {

    _loadBannerAd();


    super.initState();



  }

  String appKey (){

    final appKey = Platform.isAndroid
        ? "85460dcd"
        : Platform.isIOS
        ? "8545d445"
        : throw Exception("Unsupported Platform");

    return appKey;
  }

  Future<void> _loadBannerAd() async {
    await IronSource.loadBanner(
      placementName: "YOUR_PLACEMENT_NAME",
      size: IronSourceBannerSize.BANNER, position: IronSourceBannerPosition.Bottom,
      verticalOffset: -100,

    );
  }
  @override
  Widget build(BuildContext context) {
    IronSource.init(
      appKey: appKey(),
      adUnits: [IronSourceAdUnit.RewardedVideo,

        IronSourceAdUnit.Banner,],
    );
    return  MaterialApp(
        theme: _switch ? _dark : _light,
        home: Scaffold(
            appBar: AppBar(
              title: const Text(ConstsData.app_name,
              ),
              elevation: 0,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [


                      const Icon(CupertinoIcons.sun_max),
                      Switch(
                          value: _switch,
                          onChanged: (_newvalue) {
                            setState(() {
                              _switch = _newvalue;

                            });
                          }),
                      const Icon(CupertinoIcons.moon_stars_fill)
                    ],
                  ),
                )
              ],
            ),
            // body: getScreen(),

            body: getScreen(),
            // body: MyHomePage(),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => setState(() => _currentIndex = index),
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

        )
    );
  }

  Widget IndexScreen(){

    return IndexedStack(
      index: _currentIndex,
      children: [
        const MyPostPage2(), // MyPostPage is preserved in the IndexedStack
        Navigator(
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const MyProfile(); // MyProfilePage is managed by the Navigator
              },
            );
          },
        ),
      ],
    );
  }
  //
  // Widget getScreen2(){
  //
  //   var screens = [ const MyPostPage2(), const MyProfile()];
  //
  //   return IndexedStack(
  //     index: currentIndex,
  //     children: screens,
  //   );
  // }
  //
  //
  Widget getScreen() {
    var screens = [ const MyPostPage2(), const MyProfile()];
    return screens[_currentIndex];
  }
}
