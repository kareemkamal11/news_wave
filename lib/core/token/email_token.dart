import 'package:shared_preferences/shared_preferences.dart';

class EmailToken {
  static Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }


  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  

  static Future<void> removeEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
  }
}
