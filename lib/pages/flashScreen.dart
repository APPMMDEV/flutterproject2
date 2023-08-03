import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/pages/postPage.dart';

import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';
import 'ProfilePage.dart';

class FlashScreen extends StatefulWidget {

  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}


class _FlashScreenState extends State<FlashScreen> {

  int currentIndex = 0;

  bool _switch = false;
  ThemeData _dark = darkTheme;
  ThemeData _light = lightTheme;

  var darkicon = Icons.dark_mode;
  var lighticon = Icons.light_mode;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: _switch ? _dark : _light,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(ConstsData.app_name,
            ),
            elevation: 0,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 20),
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
              )
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
  var screens = [MyPostPage(),MyProfile()];
    return Container(

      child: screens[currentIndex],
      );
}
}
