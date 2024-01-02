import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefClass{
  static late SharedPreferences pref;
  static bool CheckLogging(){
    return pref.getBool("isLogged") ?? false;
  }
}