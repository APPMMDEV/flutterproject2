import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/Helper/ConvertPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var pts = '0 pts';
  var tclick = 'o click';





  @override
  void initState() {

   getPts();
   getTotalClick();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(

                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70,bottom: 30),
                    child: const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 85,

                        child: CircleAvatar(
                          radius: 79,
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/007/610/209/original/flying-phoenix-fire-bird-abstract-logo-design-template-vector.jpg'),


                        ),
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
                      padding: EdgeInsets.all(20),
                      height: 170,
                      child: Card(
                        elevation: 5,
                        // color: Colors.blueGrey,

                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(30)),

                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: Text(
                                          'My Points',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '${pts} points',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Center(
                              child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Total Click',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '${tclick} click',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

        ],
        )),


    );
  }

  void getPts() async{

    var pointpref = await SharedPreferences.getInstance();
    int i = pointpref.getInt('key') ?? 0;

    setState(() {
      pts = i.toString();
    });
  }

  void getTotalClick() async{

    var totalpointPref = await SharedPreferences.getInstance();
    int j = totalpointPref.getInt('total') ?? 0;

    setState(() {
      tclick = j.toString();
    });
  }

}
