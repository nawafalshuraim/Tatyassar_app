import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/styles/shadow.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/rounded_images/rounded_image.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/common/widgets/texts/product_title_text.dart';
import 'package:loom_store/features/shop/screens/product_datails/product_detail.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CProductCardVertical extends StatelessWidget {
  const CProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: ()=> Get.to(()=> const ProductDetail()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [CShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(CSizes.productImageRadius),
            color: dark ? CColors.darkGrey : CColors.white),
        child: Column(
          children: [
            //thumbnail
            CRoundedContainer(
              width: 180,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.light,
              child: Stack(
                children: [
                  CRoundImage(
                      imageUrl: CImages.carpenter, applyImageRadious: true),
      
                  // sale tag
                  CRoundedContainer(
                    radius: CSizes.sm,
                    backgroundColor: CColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: CSizes.sm, vertical: CSizes.xs),
                    child: Text('3%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: CColors.black)),
                  )
                  //favorite Icon
                  //no need
      
                  // button
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwItems / 2),
      
            //datails
            Padding(
              padding: const EdgeInsets.only(left: CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CProductTitleText(title: 'carpenter', smallSize: true),
                  SizedBox(height: CSizes.spaceBtwItems / 2),
                ],
              ),
            ),
            Spacer(),

                  // price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: CSizes.sm  ),
                        child: const CProductpriceText(price: '29'),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: CColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(CSizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(CSizes.productImageRadius))),
                        child: SizedBox(
                          width: CSizes.iconLg * 1.2,
                          height: CSizes.iconLg * 1.2,
                          child: const Icon(Iconsax.add, color: CColors.white)),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
