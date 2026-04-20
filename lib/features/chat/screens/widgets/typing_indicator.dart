import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 0),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isDark
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final phase = (_controller.value * 3 - index).clamp(0.0, 1.0);
                final bounce = phase < 0.5 ? phase * 2 : (1 - phase) * 2;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: Transform.translate(
                    offset: Offset(0, -6 * bounce),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
