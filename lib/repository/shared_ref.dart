import 'package:shared_preferences/shared_preferences.dart';

class SharedRefRepo {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await _prefs;
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  Future<bool> hasLoginDetails() async {
    final SharedPreferences prefs = await _prefs;
    var hasLogin = prefs.getBool('has_login');
    if (hasLogin != null && hasLogin) {

      return true;

    } else {
      return false;
    }
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await _prefs;
    var email = prefs.get("email");

    return email.toString();
  }

  Future<String> getPassword() async {
    final SharedPreferences prefs = await _prefs;
    var password = prefs.get("password");

    return password.toString();
  }

  Future<bool> saveUserCredential(String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('has_login', true);
    prefs.setString('email', email);
    prefs.setString('password', password);

    return true;
  }
}
