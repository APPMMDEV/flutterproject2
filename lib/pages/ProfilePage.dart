import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/Database/pointDatabase.dart';
import 'package:nwayooknowledge/Helper/Components.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';

import '../Database/pointTable.dart';

class MyProfile extends StatefulWidget {
  final PointDAO pointDAO;
  const MyProfile({super.key, required this.pointDAO});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var pts = '0 pts';

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
              const Text('Nway Oo Knowledge',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 150,
                  child: Card(
                    color: Theme.of(context).colorScheme.onBackground,
                    elevation: 5,
                    // color: Colors.blueGrey,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    shadowColor: Theme.of(context).colorScheme.secondary,
                    child: Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Points',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary,
                              ),
                            ),
                            Text(
                              '${pts} points',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              StreamBuilder<List<PointData>>(
                stream: widget.pointDAO.getAllPoints(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {

                    // return
                    return Column(
                      children: [

                        Text(snapshot.data![4].id.toString()
                        ),
                        // Container(
                        //   color: Colors.redAccent,
                        //
                        //   child: ListView.builder(
                        //       itemCount: snapshot.data!.length,
                        //       itemBuilder: (context,index){
                        //
                        //         return Components.getPtsData(context, snapshot.data![index]);
                        //
                        //   })
                        //   // child: Column(
                        //   //
                        //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   //
                        //   //   children: [
                        //   //
                        //   //     Text(snapshot.data!.length.toString()),
                        //   //     Text(snapshot.data![3].id.toString()),
                        //   //     ListView.builder(
                        //   //         itemCount: snapshot.data!.length,
                        //   //         itemBuilder: (context, index) {
                        //   //           return ListTile(
                        //   //             title: Text(snapshot.data![3].timeStamp
                        //   //                 .toString()),
                        //   //           );
                        //   //
                        //   //           // return Text('${snapshot.data![index].toString()} time');
                        //   //         }),
                        //   //   ],
                        //   // ),
                        // ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error Getting Data'));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            //
            var timeStamp = DateTime.now().millisecondsSinceEpoch;
            setState(() {
              Fluttertoast.showToast(
                msg: "${timeStamp}",
              );
            });

            widget.pointDAO.addPoint(new PointData(2, timeStamp));
          }),
    );
  }

  Widget PointList() {
    return StreamBuilder<List<PointData>>(
      stream: widget.pointDAO.getAllPoints(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          Fluttertoast.showToast(
            msg: "${snapshot.data!.length.toString()}",
          );
          // return
          return Container(
            color: Colors.redAccent,
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].timeStamp.toString()),
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
