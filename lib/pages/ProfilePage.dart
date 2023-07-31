import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/ConstsData.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  var pts = '0 pts';


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: ConstsData.getPts(),
      builder: (context,snapshot) {
        if (snapshot.hasData) {

          pts = snapshot.data.toString();


        }else{
          pts = 'Error';
        }

        return Container(


          child: Column(
            children: [

              Container(
                margin: EdgeInsets.all(20),
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 85,
                    child: CircleAvatar(
                      radius: 79,
                      backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/007/610/209/original/flying-phoenix-fire-bird-abstract-logo-design-template-vector.jpg'),
                    ),
                  ),
                ),
              ),

              const Text('Nway Oo Knowledge',style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold)),
              Text('$pts\tpts',style: const TextStyle(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold))
            ],
          ),
        );

      }
    );
  }
}
