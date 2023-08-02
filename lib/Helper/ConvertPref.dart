import 'package:intl/intl.dart';

class Convert_Pref{

  static String readTimestamp(int timestamp) {
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var format = DateFormat.yMd().add_jms();
    var time  = format.format(date) ;


    return time;
  }

  String parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(date);
    return d12;
  }
}