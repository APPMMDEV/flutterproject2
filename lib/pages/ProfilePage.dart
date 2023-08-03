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





  @override
  void initState() {

   getPts();
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
                    margin: EdgeInsets.all(20),
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
                      height: 110,
                      child: Card(
                        elevation: 5,
                        // color: Colors.blueGrey,

                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(30)),

                        child: Center(
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
                      ),
                    ),
                  ),
                ],
              ),
            ),

        ],
        )),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //
      //     showDialog(context: context, builder: (context){
      //
      //       return   AlertDialog(
      //
      //         title: Text('Are you sure?'),
      //         content: Text('Delete Data'),
      //         actions: [
      //           ElevatedButton(onPressed: (){
      //
      //             if(ptls!=null){
      //
      //
      //
      //               setState(() {
      //                 widget.pointDAO.DeleteAll(ptls!);
      //
      //               });
      //             }else {
      //
      //                showDialog(context: context, builder: (context){
      //
      //                 return AlertDialog(
      //
      //                    title: Text('Data Null'),
      //                    content: Text('Delete Data Null'),
      //                    actions: [
      //                      ElevatedButton(onPressed: (){
      //
      //
      //
      //
      //
      //                      }, child:
      //                      Text('OK'))
      //                    ],
      //
      //                  );
      //                });
      //
      //             }
      //
      //           }, child:
      //           Text('OK'))
      //         ],
      //
      //       );
      //     });
      //
      //
      //   },
      // ),
    );
  }

  void getPts() async{

    var pointpref = await SharedPreferences.getInstance();
      int i = pointpref.getInt('key') ?? 0;

      setState(() {
        pts = i.toString();
      });
  }

}
