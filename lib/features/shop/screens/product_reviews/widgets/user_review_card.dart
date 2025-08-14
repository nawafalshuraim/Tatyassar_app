import 'package:flutter/material.dart';
import 'package:loom_store/common/products/ratings/rating_indicator.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(CImages.userProfileImage2)),
                const SizedBox(width: CSizes.spaceBtwItems),
                Text('Nawaf Alshammari',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems),

        //user review
        Row(
          children: [
            const CRatingBarIndicator(rating: 4),
            const SizedBox(width: CSizes.spaceBtwItems),
            Text('July 14, 2025', style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems),
        const ReadMoreText(
          'The UI is cool. I was able to navigate and make purchases seamlessly. Also, the service was very good and worth the price.',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CColors.primary),
        ),
        const SizedBox(height: CSizes.spaceBtwItems),
        //company review
        CRoundedContainer(
          backgroundColor: dark? CColors.darkerGrey : CColors.grey,
          child: Padding(
            padding: EdgeInsets.all(CSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                   Text('LeanFIX', style: Theme.of(context).textTheme.titleMedium),
                   Text('July 15, 2025', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),

        const SizedBox(height: CSizes.spaceBtwItems),
        const ReadMoreText(
          'The UI is cool. I was able to navigate and make purchases seamlessly. Also, the service was very good and worth the price.',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CColors.primary),
        ),

              ],
            ),
          ),
        ),
        const SizedBox(height: CSizes.spaceBtwSections),
      ],
    );
  }
}
