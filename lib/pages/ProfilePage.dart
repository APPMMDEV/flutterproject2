import 'package:flutter/material.dart';

import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/Helper/ConvertPref.dart';
import 'package:nwayooknowledge/Helper/MethodsHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var pts = '0';
  var tclick = '0';

  @override
  void initState()  {


getPtsFromSharePref();
getTotalClick();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 30),
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
                      elevation: 10,
                      color: Colors.blueAccent,
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
      )),
    );
  }

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
}
