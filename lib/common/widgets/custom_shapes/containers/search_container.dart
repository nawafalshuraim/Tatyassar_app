import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/device/device_utility.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CSearchContainer extends StatelessWidget {
  const CSearchContainer({
    super.key, 
    this.icon = Iconsax.search_normal, 
    this.showBackgroung = true,  
    this.showBorder = true, 
    required this.text,
    this.onTap,
  });

  final bool showBackgroung, showBorder;
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
        child: Container(
          width: CDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(CSizes.md),
          decoration: BoxDecoration(
            color: showBackgroung ? dark ? CColors.dark : CColors.light : Colors.transparent,
            borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
            border: showBorder? Border.all(color: CColors.grey) : null,
          ),
      
        child: Row(
          children: [
            Icon(icon, color: CColors.darkerGrey,),
            const SizedBox(width: CSizes.spaceBtwItems,),
            Text(text, style: Theme.of(context).textTheme.bodySmall),
      
      
          ],
        ),
          
        ),
      ),
    );
  }
}



