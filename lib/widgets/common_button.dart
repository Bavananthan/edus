import 'package:flutter/material.dart';

import '../provider/locator.dart';
import 'common_text.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final bool isApiCall;
  const CommonButton(
      {super.key,
      required this.title,
      this.isApiCall = false,
      required this.onPressed,
      this.color = const Color(0xff00345F)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(13),
        // margin: const EdgeInsets.symmetric(horizontal: 16),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.blue, colors.brandColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        // decoration: BoxDecoration(
        //   color: color,
        //   borderRadius: BorderRadius.circular(8),
        // ),
        child: Center(
          child: isApiCall
              ? CircularProgressIndicator(
                  color: colors.white,
                )
              : commonText(
                  text: title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: colors.white,
                  fontSize: texts.textSize16,
                  fontWeight: texts.medium),
        ),
      ),
    );
  }
}
