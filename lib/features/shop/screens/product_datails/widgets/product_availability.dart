import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/texts/product_title_text.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CProductAvailability extends StatelessWidget {
  const CProductAvailability({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CProductTitleText(title: 'status'),
        const SizedBox(width: CSizes.spaceBtwItems),
        Text('available',style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
