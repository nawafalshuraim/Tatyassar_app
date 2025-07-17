import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CBillingAmountSection extends StatelessWidget {
  const CBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            //subtotal
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                    Text('subtotal', style: Theme.of(context).textTheme.bodyMedium),
                    Text('SAR 560', style: Theme.of(context).textTheme.bodyMedium),
                ],
            ),
            const SizedBox( height: CSizes.spaceBtwItems / 2),

            //tax fee
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                    Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
                    Text('SAR 84', style: Theme.of(context).textTheme.labelLarge),
                ],
            ),
            const SizedBox( height: CSizes.spaceBtwItems / 2),

            //order total
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                    Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
                    Text('SAR 644', style: Theme.of(context).textTheme.titleMedium),
                ],
            ),
        ],
    );
  }
}