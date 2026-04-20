import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/device/device_utility.dart';
import 'package:tatyassar/utils/helpers/helper_functions.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.centerTitle = false, 

  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool centerTitle; 

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.md),
      child: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Iconsax.arrow_left,
                  color: dark ? CColors.white : CColors.dark, 
                ),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(
                      leadingIcon,
                      color: dark ? CColors.white : CColors.dark, 
                    ),
                  )
                : null,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(CDeviceUtils.getAppBarHeight());
}