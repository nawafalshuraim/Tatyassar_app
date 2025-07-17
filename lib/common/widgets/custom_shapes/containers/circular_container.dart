import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/colors.dart';

class CCircularContianer extends StatelessWidget {
  const CCircularContianer({
  super.key,
  this.width = 400,
  this.height = 400,
  this.radius = 400,
  this.padding = 0,
  this.child,
  this.backgroundcolor = CColors.white,
  this.margin,
  this.image,
});

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundcolor;
  final String? image; // NEW: optional image path

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundcolor,
        image: image != null
            ? DecorationImage(
                image: AssetImage(image!), // or use NetworkImage if needed
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
