import 'package:flutter/material.dart';

class BotMessage extends StatelessWidget {
  final String text;
  const BotMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isDark
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
