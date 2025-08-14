
import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CRoundImage extends StatelessWidget {
  const CRoundImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadious = true,
    this.border,
    this.backgroundColor,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = CSizes.md,
  });

  final double? width, height;
  // imageUrl used
  final String imageUrl;
  final bool applyImageRadious;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadious
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          // in case you get it online
          child: Image(
              fit: fit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider),
        ),
      ),
    );
  }
}
