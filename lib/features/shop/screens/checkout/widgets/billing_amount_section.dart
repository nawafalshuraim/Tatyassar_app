import 'package:flutter/material.dart';
import 'package:loom_store/features/shop/controllers/cart_controller.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/pricing_calculator.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CBillingAmountSection extends StatelessWidget {
  const CBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotle = cartController.totalCartPrice.value;
    final isDarkMode = CHelperFunctions.isDarkMode(context);

    // Helper to get icon color depending on dark mode
    Color? iconColor = isDarkMode ? Colors.white : null;

    return Column(
      children: [
        //subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/currency/Saudi_Riyal_Symbol.png',
                  width: 14,
                  height: 14,
                  color: iconColor, // apply white in dark mode
                ),
                const SizedBox(width: 4),
                Text('$subTotle', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),

        //tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Estimated VAT', style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/currency/Saudi_Riyal_Symbol.png',
                  width: 14,
                  height: 14,
                  color: iconColor, // apply white in dark mode
                ),
                const SizedBox(width: 4),
                Text('${CPricingCalculator.calculateTax(subTotle)}', style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),

        //order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total (VAT Included)', style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/currency/Saudi_Riyal_Symbol.png',
                  width: 16,
                  height: 16,
                  color: iconColor, // apply white in dark mode
                ),
                const SizedBox(width: 4),
                Text('${CPricingCalculator.calculateTotalPrice(subTotle)}', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
