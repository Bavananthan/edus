import 'package:flutter/material.dart';

import '../provider/locator.dart';
import 'common_text.dart';

class CommonDrawerCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Widget? trailing;

  const CommonDrawerCard({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.titleStyle,
    this.backgroundColor,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Color.fromARGB(255, 231, 231, 231),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: iconColor ?? colors.blue,
        ),
        title: Text(
          title,
          style: titleStyle ??
              TextStyle(
                wordSpacing: 1.5,
                letterSpacing: 1.5,
                fontSize: texts.textSize16,
                fontWeight: FontWeight.w500,
                color: colors.black,
              ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
