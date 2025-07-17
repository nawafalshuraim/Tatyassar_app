import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CBillingPaymnetSection extends StatelessWidget {
  const CBillingPaymnetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark =  CHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        CSectionHeading(title: "Payment Method", buttonTitle: 'Change', onPressed: (){}),
        const SizedBox( height: CSizes.spaceBtwItems /2),
        Row(
          children: [
            CRoundedContainer(
              width: 60,
              height: 35,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.light : CColors.white,
              child: const Image(image: AssetImage(CImages.applePay), fit: BoxFit.contain,),
            ),
            const SizedBox( width: CSizes.spaceBtwItems /2),
            Text('Apple Pay', style: Theme.of(context).textTheme.bodyLarge),

          ],
        )
      ],
    );
  }
}