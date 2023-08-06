import 'dart:convert';

import 'package:nwayooknowledge/Helper/ConstsData.dart';
import 'package:nwayooknowledge/Modal/postmodal.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/SharePerfHelper.dart';

class Api {
  static Future<List<MyPostModal>> getMyPost() async {
    Uri uri = Uri.parse(ConstsData.TestPost);
    var getresponse = await http.get(uri);
    var response = jsonDecode(getresponse.body);
    var decodedData = response['Post_DB'] as List;
    List<MyPostModal> plist =
        decodedData.map((e) => MyPostModal.fromJson(e)).toList();

    return plist;
  }

  static Future<void> fetchDataAndSaveData() async {
    Uri uri = Uri.parse(ConstsData.TestPost);
    var getresponse = await http.get(uri);
    var response = jsonDecode(getresponse.body);
    var decodedData = response['Post_DB'] as List;
    List<MyPostModal> plist =
        decodedData.map((e) => MyPostModal.fromJson(e)).toList();

    await MySharedPreferences.saveMyModelList(plist);

  }
}
