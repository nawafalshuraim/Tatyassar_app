import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CBillingAddressSection extends StatelessWidget {
  const CBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CSectionHeading(title: "Address", buttonTitle: 'Change', onPressed: (){}),
        Text('Nawaf Alshammari', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: CSizes.spaceBtwItems/ 2),

        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: CSizes.spaceBtwItems),
            Text('0542076655', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems/ 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: CSizes.spaceBtwItems),
            Expanded(child: Text('Riyafh, Al Aqiq, 14245', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,)),
          ],
        ),

      ],
    );
  }
}