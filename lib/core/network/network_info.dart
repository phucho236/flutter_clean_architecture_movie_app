import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  Future<bool> get isConnected async => (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
}
