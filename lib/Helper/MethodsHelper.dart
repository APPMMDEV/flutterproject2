import 'package:shared_preferences/shared_preferences.dart';

class MethodsHelper{

 static void setSuccessPoint() async{

    var pointpref = await SharedPreferences.getInstance();
    int i = pointpref.getInt('key') ?? 0;

    int t = pointpref.getInt('total') ?? 0;
    pointpref.setInt('key', i + 1);
    pointpref.setInt('total', t + 1);
  }

 static void setTotalClickPoint() async{

    var tpf = await SharedPreferences.getInstance();
    int i = tpf.getInt('total') ?? 0;
    tpf.setInt('total', i + 1);


  }


 static Future<int> getPtsFromSharePref() async {
   var pointpref = await SharedPreferences.getInstance();
   int i = pointpref.getInt('key') ?? 0;

   return i;
 }

 static Future<int> getTotalClickfromSharePref() async {
   var totalpointPref = await SharedPreferences.getInstance();
   int j = totalpointPref.getInt('total') ?? 0;

   return j;
 }

}