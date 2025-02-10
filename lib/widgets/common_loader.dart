import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../provider/locator.dart';
import 'common_text.dart';

class CommonLoader extends StatelessWidget {
  final String animationPath; // Path to the Lottie JSON file
  final String? message; // Optional loading message

  const CommonLoader({
    Key? key,
    required this.animationPath,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dimmed background
        Container(
          color: Colors.white.withOpacity(0.5),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lottie animation
              Lottie.asset(
                repeat: true,
                animationPath,
                width: 150,
                height: 150,
              ),
              if (message != null) ...[
                SizedBox(height: 20),
                commonText(
                    text: message!,
                    overflow: TextOverflow.ellipsis,
                    color: colors.white,
                    fontSize: texts.textSize16,
                    fontWeight: texts.medium),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
