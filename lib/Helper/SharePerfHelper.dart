import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nwayooknowledge/Modal/postmodal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String key = 'my_model_list';

  static Future<void> saveMyModelList(List<MyPostModal> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = list.map((model) => json.encode(model.toJson())).toList();
    await prefs.setStringList(key, jsonStringList);
  }

  static Future<List<MyPostModal>> getMyModelList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(key);

    if (jsonStringList == null) {
      return [];
    }

    List<MyPostModal> modelList = jsonStringList.map((jsonString) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return MyPostModal.fromJson(jsonMap);
    }).toList();

    return modelList;
  }
}
