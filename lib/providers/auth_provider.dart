import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcase_with_provider/constant.dart';

class AuthProvider with ChangeNotifier {
  bool _loginStatus = false;
  bool get loginStatus => _loginStatus;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (email == kRegisteredAccount['email'] &&
        password == kRegisteredAccount['password']) {
      _loginStatus = true;
      pref.setBool('is_logged_in', _loginStatus);

      return _loginStatus;
    } else {
      return _loginStatus;
    }
  }

  Future<void> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('is_logged_in')) {
      _loginStatus = pref.getBool('is_logged_in')!;
      notifyListeners();
    }
  }
}
