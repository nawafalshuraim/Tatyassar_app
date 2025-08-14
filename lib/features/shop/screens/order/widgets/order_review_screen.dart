import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/shop/models/order_model.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';

class OrderReviewScreen extends StatelessWidget {
  final OrderModel order;

  const OrderReviewScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Review"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: dark ? CColors.light : CColors.dark),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order Status & Date
            CRoundedContainer(
              showBorder: true,
              backgroundColor: dark ? CColors.dark : CColors.light,
              padding: const EdgeInsets.all(CSizes.md),
              child: Row(
                children: [
                  const Icon(Iconsax.car),
                  const SizedBox(width: CSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.orderStatusText,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: CColors.primary, fontWeightDelta: 1)),
                        Text(order.formattedOrderDate,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            /// Order ID & Delivery Date
            CRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(CSizes.md),
              backgroundColor: dark ? CColors.dark : CColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Order ID
                  Row(
                    children: [
                      const Icon(Iconsax.tag),
                      const SizedBox(width: CSizes.spaceBtwItems),
                      Text("Order ID:",
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(width: CSizes.sm),
                      Text(order.id,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  /// Delivery Date
                  Row(
                    children: [
                      const Icon(Iconsax.calendar_1),
                      const SizedBox(width: CSizes.spaceBtwItems),
                      Text("Delivery:",
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(width: CSizes.sm),
                      Text(order.formattedDeliveryDate,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            /// Items in Order
            Text("Items:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: CSizes.spaceBtwItems),

            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: CSizes.spaceBtwItems),
                  child: CRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(CSizes.md),
                    backgroundColor: dark ? CColors.dark : CColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: CSizes.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Qty: ${item.quantity}",
                                style: Theme.of(context).textTheme.bodyMedium),
                            CProductpriceText(
                                price: (item.price * item.quantity)
                                    .toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),

            const Divider(height: CSizes.spaceBtwSections * 2),

            /// Total Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Total (VAT Included):", style: Theme.of(context).textTheme.titleLarge),
                CProductpriceText(price: order.totalAmount.toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
