import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/pages/postPage.dart';
import 'package:nwayooknowledge/pages/pts_test.dart';

import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';
import 'ProfilePage.dart';

class FlashScreen extends StatefulWidget {

  final PointDAO pointDAO;
  const FlashScreen({super.key,required this.pointDAO});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}


class _FlashScreenState extends State<FlashScreen> {

  int currentIndex = 0;

  bool _switch = false;
  ThemeData _dark = darkTheme;
  ThemeData _light = lightTheme;


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
}
