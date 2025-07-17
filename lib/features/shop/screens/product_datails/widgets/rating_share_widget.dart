import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/shop/screens/product_reviews/product_review.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CRatingAndShare extends StatelessWidget {
  const CRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //rating
        Row(
          children: [
            Icon(Iconsax.star5,color: Colors.amber, size: 24),
            SizedBox(width: CSizes.spaceBtwItems/2),
            const CSectionHeading(title: 'Reviews (199)', showActionButton: false),
            IconButton(onPressed: ()=> Get.to(()=> const ProductReviewScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 18)),
          ],
        ),
        //share
        IconButton(onPressed: (){}, icon: const Icon(Icons.share, size: CSizes.iconMd))
    
      ],
    );
  }
}