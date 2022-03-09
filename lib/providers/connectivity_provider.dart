import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider with ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  ConnectivityResult get connectivityResult => _connectivityResult;

  Future<void> checkConnection() async {
    Connectivity connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();

    _connectivityResult = result;
    notifyListeners();
  }
}
