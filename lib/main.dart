import 'package:flutter/material.dart';
import 'package:nwayooknowledge/pages/flashScreen.dart';
import 'package:nwayooknowledge/pages/mainPage.dart';

import 'pages/flashScreen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();



  }


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: MainPage()
      ),

    );
  }

}
