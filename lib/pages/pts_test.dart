import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';

import '../Database/pointTable.dart';

class Pts_Test extends StatelessWidget {

 final PointDAO pointDAO;
  const Pts_Test({super.key,required this.pointDAO});

  @override
  Widget build(BuildContext context) {
    return PointList();
  }


  Widget PointList() {
    return StreamBuilder<List<PointData>>(
      stream: pointDAO.getAllPoints(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          Fluttertoast.showToast(
            msg: "${snapshot.data!.length.toString()}",
          );
          // return
          return Container(
            height: 200,
            color: Colors.redAccent,
            child: ListView.builder(
                itemCount: 7,
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
