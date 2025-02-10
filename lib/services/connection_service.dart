import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();

  static Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  static bool isDeviceNotConnected(ConnectivityResult result) {
    return result == ConnectivityResult.none;
  }
}
