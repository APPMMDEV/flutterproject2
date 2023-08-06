import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Helper/Components.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Components.getStremWatch(),
      ),
    );
  }
}
