import 'package:edus_project/provider/locator.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common_button.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final bool isTapped;

  const PostCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onUpdate,
      required this.onDelete,
      this.isTapped = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isTapped
            ? [
                BoxShadow(
                  color: colors.brandColor.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : [
                BoxShadow(
                  color: colors.brandColor.withOpacity(0.2),
                  blurRadius: 1,
                  spreadRadius: 1,
                )
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.double_arrow_rounded),
                Flexible(
                  child: Text(
                    title,
                    maxLines: isTapped ? null : 1,
                    overflow:
                        isTapped ? TextOverflow.visible : TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                subtitle,
                maxLines: isTapped ? null : 2,
                overflow:
                    isTapped ? TextOverflow.visible : TextOverflow.ellipsis,
                // softWrap: true,
                style: TextStyle(fontSize: 14, color: colors.grey),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isTapped) ...[
                  Flexible(
                    child: CommonButton(
                      title: "Update",
                      onPressed: onUpdate,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: CommonButton(
                      title: "Delete",
                      onPressed: onDelete,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
