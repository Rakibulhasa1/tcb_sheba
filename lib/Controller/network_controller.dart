import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


enum ConnectivityStatus { WiFi, Mobile, Offline }

class NetworkStatus with ChangeNotifier {
  ConnectivityStatus _status = ConnectivityStatus.Offline;
  ConnectivityStatus get status => _status;

  NetworkStatus() {
    _init();
  }

  Future<void> _init() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    _status = _getStatusFromResult(result);
    notifyListeners();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _status = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Mobile;
      case ConnectivityResult.none:
      default:
        return ConnectivityStatus.Offline;
    }
  }
  Future<ConnectivityStatus> initialStatus() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    return _getStatusFromResult(result);
  }
}
