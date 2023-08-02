import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/Database/pointDatabase.dart';
import 'package:nwayooknowledge/Helper/Components.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/Helper/ConvertPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database/pointTable.dart';

class MyProfile extends StatefulWidget {
  final PointDAO pointDAO;
  const MyProfile({super.key, required this.pointDAO});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var pts = '0 pts';

  List<PointData>? ptls = [] ;




  @override
  void initState() {

   getPts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            Container(

                height: 500,
                child: PointList())
          ],
        ),
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

  Widget PointList() {
    return StreamBuilder<List<PointData>>(
      stream: widget.pointDAO.getAllPoints(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {

          ptls = snapshot.data;


          // return
          return Expanded(
            child: ListView.builder(



              // reverse:  true,

                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {

                  var rev = snapshot.data!.length -1 - index;
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),


                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(

                      title: Text(Convert_Pref.readTimestamp(snapshot.data![rev].timeStamp as int)),
                      trailing: Text(snapshot.data![rev].point.toString()),

                    ),
                  );

                  // return Text('${snapshot.data![index].toString()} time');
                }),
          );
        } else if (snapshot.hasError) {
          return Text('Error Getting Data');
        } else {
          return CircularProgressIndicator(
            color: Colors.redAccent,
          );
        }
      },
    );
  }
}
