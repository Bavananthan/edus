import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../common/asserts.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (viewModel) {
        // viewModel.checkUser(context);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Center(
              child: Lottie.asset(
            repeat: false,
            animate: true,
            animation,
            onLoaded: (p0) async {
              final duration = p0.duration;
              Future.delayed(
                duration,
                () async {
                  await viewModel.handleNavigation(context);
                },
              );
            },
          )),
        );
      },
    );
  }
}
