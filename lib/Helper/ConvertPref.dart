import 'package:intl/intl.dart';

class Convert_Pref{

  static String readTimestamp(int timestamp) {


    var now = DateTime.now();
    var format = DateFormat.yMMMEd().add_jms();
    var time  = format.format(now) ;
    // if (diff.inSeconds <= 0 || diff.fluinSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    //   time = format.format(date);
    // } else if (diff.inDays > 0 && diff.inDays < 7) {
    //   if (diff.inDays == 1) {
    //     time = diff.inDays.toString() + ' DAY AGO';
    //   } else {
    //     time = diff.inDays.toString() + ' DAYS AGO';
    //   }
    // } else {
    //   if (diff.inDays == 7) {
    //     time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    //   } else {

    //     time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    //   }
    // }

    return time;
  }
}