import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/products/cart/circular_icon.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CProductQuantityWithAddAndRemoveButton extends StatelessWidget {
  const CProductQuantityWithAddAndRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //add and remove buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CCircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: CSizes.md,
              color: CHelperFunctions.isDarkMode(context) ? CColors.white : CColors.black,
              backgroundColor: CHelperFunctions.isDarkMode(context) ? CColors.darkGrey : CColors.light,
            ),
          ],
        ),
          const SizedBox(width: CSizes.spaceBtwItems),
          Text('2', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(width: CSizes.spaceBtwItems),
    
          CCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: CSizes.md,
          color: CColors.white,
          backgroundColor: CColors.primary,
        ),
    
      ],
    );
  }
}
