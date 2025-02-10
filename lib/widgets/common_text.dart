import 'package:flutter/material.dart';

import '../provider/locator.dart';
import 'common_text.dart';

Text commonText({
  required String text, // The text to display
  Key? key, // Optional key
  bool isCurrency = false,
  TextAlign? textAlign, // Optional text alignment
  int? maxLines, // Optional maximum number of lines
  TextOverflow? overflow, // Optional overflow handling

  Locale? locale, // Optional locale
  bool? softWrap, // Optional soft wrap
  double? letterSpacing, // Optional letter spacing
  double? wordSpacing, // Optional word spacing
  double? height, // Optional line height
  FontWeight? fontWeight, // Optional font weight
  Color? color, // Optional text color
  double? fontSize = 16, // Optional font size
}) {
  return Text(
    text,
    key: key,
    style: TextStyle(
      fontSize: fontSize ?? texts.textSize16,
      color: color,
      fontWeight: fontWeight ?? texts.bold,
      letterSpacing: letterSpacing ?? 1.5,
      wordSpacing: wordSpacing ?? 1,
      height: height,
    ),
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
    locale: locale,
    softWrap: softWrap ?? true,
  );
}
