import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/shimmer/shimmer.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CHorizontalProductShimmer extends StatelessWidget {
  const CHorizontalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: CSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            CShimmerEffect(width: 120, height: 120),
            SizedBox(width: CSizes.spaceBtwItems),

            /// Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: CSizes.spaceBtwItems / 2),
                CShimmerEffect(width: 160, height: 15),
                SizedBox(height: CSizes.spaceBtwItems / 2),
                CShimmerEffect(width: 110, height: 15),
                SizedBox(height: CSizes.spaceBtwItems / 2),
                CShimmerEffect(width: 80, height: 15),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}