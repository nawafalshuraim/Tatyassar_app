import 'package:flutter/material.dart';
import 'package:tatyassar/utils/constants/colors.dart';

class UserMessage extends StatelessWidget {
  final String text;
  const UserMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: CColors.primary.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
