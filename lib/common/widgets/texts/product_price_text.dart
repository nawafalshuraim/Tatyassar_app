import 'package:flutter/material.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CProductpriceText extends StatelessWidget {
  const CProductpriceText({
    super.key,
    this.showCurrencyIcon = true,
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.color,
  });

  final bool showCurrencyIcon;
  final String price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CHelperFunctions.isDarkMode(context);
    final baseTextStyle = isLarge
        ? Theme.of(context).textTheme.headlineMedium!
        : Theme.of(context).textTheme.titleLarge!;

    // determine text color:
    // If lineThrough: always grey 
    // else use passed color or fallback to white/black depending on dark mode
    final textColor = lineThrough
        ? Colors.grey
        : (color ?? (isDarkMode ? Colors.white : Colors.black));

    final textStyle = baseTextStyle.copyWith(
      color: textColor,
      decoration: lineThrough ? TextDecoration.lineThrough : null,
    );

    if (showCurrencyIcon) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/currency/Saudi_Riyal_Symbol.png',
            width: lineThrough ? 12 : (isLarge ? 20 : 16),
            height: lineThrough ? 12 : (isLarge ? 20 : 16),
            color: lineThrough
                ? Colors.grey
                : textColor,
          ),
          SizedBox(width: lineThrough ? 2 : 4),
          Flexible(
            child: Text(
              price,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
          ),
        ],
      );
    }

    return Text(
      price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
    );
  }
}
