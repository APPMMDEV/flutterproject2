import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Api/Api.dart';
import 'package:nwayooknowledge/pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Your splash screen will be the first screen displayed
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {

    try{
      await Api.fetchDataAndSaveData().then((value) =>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()))
      );

    }catch(e){

      _showSnackBar(context,e.toString()  );

    }


  }
  void _showSnackBar(BuildContext context , error) {
    final snackBar = SnackBar(
      content: Text(error),
      duration: Duration(seconds: 3), // Duration for which the SnackBar is displayed
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Code to execute when 'Close' is pressed on the SnackBar
          // This can be used to undo an action or dismiss the SnackBar manually
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    // Show the SnackBar using the ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16), // Add some spacing between the CircularProgressIndicator and the Text
            Text('Loading'),
          ],
        ),

          // play a loading indicator while the Future is running
      ),
    );
  }


}

