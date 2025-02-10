import 'package:flutter/material.dart';

import '../provider/locator.dart';
import 'common_text.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final double radius;
  final bool isPop;

  const CommonHeader(
      {super.key, required this.title, this.radius = 16.0, this.isPop = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.brandColor2, colors.brandColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius)),
      ),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15.0, left: 15, bottom: 15, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isPop)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: colors.white,
                  ),
                ),
              Flexible(
                  child: Center(
                child: commonText(
                    text: title,
                    overflow: TextOverflow.ellipsis,
                    color: colors.white,
                    fontSize: texts.textSize20,
                    fontWeight: texts.bold),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
