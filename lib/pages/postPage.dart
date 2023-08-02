import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/Modal/postmodal.dart';

import '../Api/Api.dart';
import '../Helper/Components.dart';

class MyPostPage extends StatefulWidget {

  final PointDAO pointDAO;
  const MyPostPage({super.key,required this.pointDAO});

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  List<MyPostModal> myPost = [];

  late MyPostModal postDatabase;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: FutureBuilder(
        future: Api.getMyPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Components.getPostCardContainer(
                        context, snapshot.data![index],widget.pointDAO);

                        
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
        },
      ),
    );
  }

  Widget myimg(MyPostModal postDatabase) {
    return Image.network(postDatabase.image);
  }
}
