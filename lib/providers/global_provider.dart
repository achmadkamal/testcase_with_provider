import 'package:flutter/foundation.dart';

class GlobalProvider with ChangeNotifier {
  bool _hidePassword = false;
  bool get getHidePassword => _hidePassword;
  set setHidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }
}
