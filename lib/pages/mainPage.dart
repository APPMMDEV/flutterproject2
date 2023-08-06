import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/Components.dart';
import 'package:nwayooknowledge/pages/postPage2.dart';

import '../Helper/ConstsData.dart';
import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool _switch = false;
  final ThemeData _dark = darkTheme;
  final ThemeData _light = lightTheme;

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
              )
            ],
          ),
    // body: MyPostPage2(),

          body: Components.getStremWatch(),

    )
    );
  }
}
