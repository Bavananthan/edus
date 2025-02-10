import 'package:flutter/material.dart';

import '../provider/locator.dart';
import 'common_text.dart';

class CommonDialog {
  static Future<bool> show({
    required BuildContext context,
    required String title,
    String? message,
    String? yesButtonText = "Yes",
    String? noButtonText = "No",
    Color? backgroundColor,
    TextStyle? titleTextStyle,
    TextStyle? messageTextStyle,
    ButtonStyle? yesButtonStyle,
    ButtonStyle? noButtonStyle,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          backgroundColor: backgroundColor ?? colors.white,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                commonText(
                    text: title,
                    overflow: TextOverflow.ellipsis,
                    color: colors.black,
                    fontSize: texts.textSize22,
                    fontWeight: texts.bold),

                const SizedBox(height: 16.0),

                // Message
                if (message != null)
                  commonText(
                      maxLines: 3,
                      text: message,
                      overflow: TextOverflow.ellipsis,
                      color: colors.gray,
                      fontSize: texts.textSize16,
                      textAlign: TextAlign.center,
                      fontWeight: texts.medium),

                const SizedBox(height: 24.0),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // Return false
                        },
                        style: noButtonStyle ??
                            OutlinedButton.styleFrom(
                              side: BorderSide(color: colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                        child: commonText(
                            text: noButtonText!,
                            overflow: TextOverflow.ellipsis,
                            color: colors.red,
                            fontSize: texts.textSize16,
                            textAlign: TextAlign.center,
                            fontWeight: texts.medium),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // Return true
                        },
                        style: yesButtonStyle ??
                            ElevatedButton.styleFrom(
                              backgroundColor: colors.brandColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                        child: commonText(
                            text: yesButtonText!,
                            overflow: TextOverflow.ellipsis,
                            color: colors.white,
                            fontSize: texts.textSize16,
                            textAlign: TextAlign.center,
                            fontWeight: texts.medium),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result ?? false; // Default to false if dismissed
  }
}
