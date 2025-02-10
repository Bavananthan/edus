import 'package:edus_project/screen/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  handleNavigation(BuildContext context) {
    // Navigate to the main screen
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
        (Route<dynamic> route) => false);
  }
}
