import 'package:flutter/material.dart';

import '../provider/locator.dart';
import 'common_text.dart';

class CommonContainer extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;

  const CommonContainer({
    Key? key,
    this.child,
    this.children,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15),
      padding: padding ??
          EdgeInsets.only(
            bottom: 10.0,
            top: 10,
          ),
      alignment: alignment,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [colors.brandColor2, colors.brandColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
      child: children != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: children!,
            )
          : child,
    );
  }
}
