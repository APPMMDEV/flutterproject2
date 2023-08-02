import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Modal/postmodal.dart';

import '../Helper/ConvertPref.dart';

class viewPost extends StatefulWidget {
  final MyPostModal postDatabase;
  const viewPost({super.key, required this.postDatabase});

  @override
  State<viewPost> createState() => _viewPostState();
}

class _viewPostState extends State<viewPost> {
  bool _mmlanguage = false;

  String mtitle = '';
  String engtitle = '';

  var ptitle = '';
  var content = '';

  @override
  void initState() {
    ptitle = widget.postDatabase.engtitle;
    content = widget.postDatabase.engcontent;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'ENG',
                ),
                Switch(
                    value: _mmlanguage,
                    onChanged: (_newvalue) {
                      setState(() {
                        if (_mmlanguage) {
                          ptitle = widget.postDatabase.engtitle;
                          content = widget.postDatabase.engcontent;
                        } else {
                          ptitle = widget.postDatabase.mmtitle;
                          content = widget.postDatabase.mmcontent;
                        }

                        _mmlanguage = _newvalue;
                      });
                    }),
                const Text(
                  'MM',
                ),
              ],
            ),
          )
        ],
        title: Text(
          ptitle,
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 10,),
             Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.blueGrey,
                    ),
                    child: Text(
                      'Author : : ${widget.postDatabase.author}',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.blueGrey,
                    ),
                    child: Text(
                      'Source : : ${widget.postDatabase.source}',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Center(
                child: Image.network(
              widget.postDatabase.image,
              height: 200,
            )),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.topRight,
              child: Text(
                Convert_Pref.readTimestamp(
                    int.parse(widget.postDatabase.timeStamp)),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
           
            SizedBox(height: 20),

            // Container(
            //   height: MediaQuery.of(context).size.height * 0.45,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       image: DecorationImage(
            //           image: NetworkImage(widget.postDatabase.image),
            //           fit: BoxFit.cover)),
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                content,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
