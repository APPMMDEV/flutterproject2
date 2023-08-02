import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class ConstsData {
  static var PostApi =
      'https://mctvteam.github.io/Coder/Data/V10/testPostNew.json';
  static var LyricApi = 'https://appmmdev.github.io/MMLyric/Data/lyrics.json';
  static var TestPost = 'https://appmmdev.github.io/MMLyric/Data/test.json';
  static var temporaryimg =
      'https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png';

  static var MusicApi =
      'https://jackrevo95.github.io/jackrevo/NOR6/Music/music.json';
  static var PostApi1 =
      'https://jackrevo95.github.io/jackrevo/NOR6/Post/post.json';

  static Future<String> getPts() async {
    var pointpref = await SharedPreferences.getInstance();
    var ptss = pointpref.getInt('key') ?? 0;

    return ptss.toString();
  }

  static const app_name = 'Nway Oo Knowledge';
  static const myprimarycolor = Color(0xFFF17006);
  static const mysecondarycolor = Color.fromARGB(255, 30, 51, 90);
  static const mycardcolor = Color.fromARGB(255, 4, 79, 122);
  static const mythirdarycolor = Color.fromARGB(255, 238, 255, 0);
}
