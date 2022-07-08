import 'package:DoorStep/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
   setFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool(alreadyUsed, true);
  }
   Future<bool> getFirst() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     bool first = (prefs.getBool(alreadyUsed) ?? false);
     return first;


   }
}