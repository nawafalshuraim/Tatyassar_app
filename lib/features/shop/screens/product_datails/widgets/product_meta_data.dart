import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/common/widgets/texts/product_title_text.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final dark = CHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // single product: sale price, price, and title
        Row(
          children: [
            //sale Price
            CRoundedContainer(
              radius: CSizes.sm,
              backgroundColor: CColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: CSizes.sm, vertical: CSizes.xs),
              child: Text('30%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: CColors.black)),
            ),
            const SizedBox(width: CSizes.spaceBtwItems),

            //price
            Text('SAR 200',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: CSizes.spaceBtwItems),
            const CProductpriceText(price: '140', isLarge: true),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems/ 1.5),

        // title
        CProductTitleText(title: 'Installation of door frame'),
        const SizedBox(height: CSizes.spaceBtwItems/ 1.5),

        
      ],
    );
  }
}

