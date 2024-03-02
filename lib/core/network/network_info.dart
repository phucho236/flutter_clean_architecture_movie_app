import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  Future<bool> get isConnected async => (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
}

class NetworkInfoConnectedTest extends NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

class NetworkInfoUnconnectedTest extends NetworkInfo {
  @override
  Future<bool> get isConnected async => false;
}
