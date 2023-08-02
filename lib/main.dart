import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nwayooknowledge/Database/pointDatabase.dart';
import 'package:nwayooknowledge/pages/flashScreen.dart';
import 'package:nwayooknowledge/pages/postPage.dart';
import 'package:nwayooknowledge/app_screen.dart';
import 'package:nwayooknowledge/theme/dark_theme.dart';
import 'package:nwayooknowledge/utils.dart';
import 'pages/ProfilePage.dart';
import 'sections/banner_section.dart';
import 'sections/rewarded_video_manual_load_section.dart';
import 'theme/light_theme.dart';

const _APP_USER_ID = 'some-unique-app-user-id-123';
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
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: SafeArea(
          child: FutureBuilder<PointDatabase>(
            future: $FloorPointDatabase.databaseBuilder('point.db').build(),
            builder: (context,snapshot){

              if(snapshot.hasData){

                return FlashScreen(pointDAO: snapshot.data!.pointDao);

                // return Text('Data has');
                
              }else if(snapshot.hasError){

                return Text('Error');

              }else{

                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),

    );
  }

}
