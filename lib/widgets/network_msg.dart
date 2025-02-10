import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../provider/locator.dart';
import 'common_text.dart';

class NetworkMonitor {
  NetworkMonitor() {
    startMonitoring(scaffoldMessengerKey);
  }

  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future startMonitoring(
      GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
    connectivityStream.listen((status) {
      final isNotConnected =
          status.every((result) => isDeviceNotConnected(result));
      try {
        if (isNotConnected) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('No internet connection!'),
              backgroundColor: Colors.red,
              duration:
                  Duration(days: 1), // Ensure it stays until manually dismissed
            ),
          );
        } else {
          scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: commonText(
                  text: 'Network Connected.',
                  overflow: TextOverflow.ellipsis,
                  color: colors.white,
                  fontSize: texts.textSize14,
                  textAlign: TextAlign.center,
                  fontWeight: texts.medium),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        app.printStatement(e);
      }
    }, onError: (error) {
      app.printStatement(error);
    });
  }

  static bool isDeviceNotConnected(ConnectivityResult result) {
    return result == ConnectivityResult.none;
  }
}
