

import 'package:flutter/material.dart';

import 'mysharepref.dart';
import 'testModal.dart';

class MyTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyModel> myModelList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<MyModel> data = await MySharedPreferences.getMyModelList();
    setState(() {
      myModelList = data;
    });
  }

  void _saveData() async {
    await MySharedPreferences.saveMyModelList(myModelList);
  }

  void _addModel() {
    setState(() {
      myModelList.add(MyModel(name: 'John', age: 25));
    });
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Demo'),
      ),
      body: ListView.builder(
        itemCount: myModelList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myModelList[index].name),
            subtitle: Text('Age: ${myModelList[index].age}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addModel,
        child: Icon(Icons.add),
      ),
    );
  }
}
