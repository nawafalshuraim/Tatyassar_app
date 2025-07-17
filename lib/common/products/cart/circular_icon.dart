import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CCircularIcon extends StatelessWidget {
  const CCircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = CSizes.lg,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : CHelperFunctions.isDarkMode(context)
                ? CColors.black.withOpacity(0.9)
                : CColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ), // BoxDecoration
      child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    ); // Container
  }
}
