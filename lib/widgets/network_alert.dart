import 'package:flutter/material.dart';

import '../common/asserts.dart';
import '../provider/locator.dart';
import 'common_button.dart';
import 'common_text.dart';

class NetworkAlert extends StatelessWidget {
  const NetworkAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 100, child: Image.asset(networkIssue)),
            const SizedBox(height: 32),
            commonText(
                text: "Woops!",
                overflow: TextOverflow.ellipsis,
                color: colors.gray,
                fontSize: texts.textSize16,
                textAlign: TextAlign.center,
                fontWeight: texts.medium),
            const SizedBox(height: 16),
            commonText(
                text: "No internet connection found.",
                overflow: TextOverflow.ellipsis,
                color: colors.shadow,
                fontSize: texts.textSize14,
                textAlign: TextAlign.center,
                fontWeight: texts.medium),
            const SizedBox(height: 8),
            commonText(
                text: "Check your connection and try again.",
                overflow: TextOverflow.ellipsis,
                color: colors.shadow,
                fontSize: texts.textSize12,
                textAlign: TextAlign.center,
                fontWeight: texts.medium),
            const SizedBox(height: 16),
            CommonButton(
              title: "Try Again",
              onPressed: () {
                Navigator.of(context).maybePop();
                // _isDialogVisible = false;
              },
            )
          ],
        ),
      ),
    );
  }
}
