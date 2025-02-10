import 'package:edus_project/screen/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'provider/customer_provider.dart';
import 'provider/locator.dart';
import 'services/connection_service.dart';
import 'widgets/network_alert.dart';
import 'widgets/network_msg.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  NetworkMonitor();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CustomerProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Edus',
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          // routes: routes,
          theme: ThemeData(
            fontFamily: 'verlag',
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff00345F)),
            useMaterial3: true,
          ),
          home: StreamBuilder(
            stream: ConnectivityService.connectivityStream,
            builder: (context, snapshot) {
              final result = snapshot.data?.every((result) =>
                      ConnectivityService.isDeviceNotConnected(result)) ??
                  false;

              return result ? const NetworkAlert() : const SplashView();
            },
          )),
    );
  }
}
