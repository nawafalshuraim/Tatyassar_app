import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/products/checkout_cart/add_remove_button.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/features/shop/controllers/cart_controller.dart';
import 'package:loom_store/features/shop/screens/product_datails/widgets/product_meta_data.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CCartItems extends StatelessWidget {
  const CCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: CSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product metadata (title, image, etc.)
              CProductMetaData(cartItem: item),

              const SizedBox(height: CSizes.spaceBtwItems / 2),

              if (showAddRemoveButtons) ...[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: CSizes.spaceBtwItems),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CProductQuantityWithAddAndRemoveButton(
                                quantity: item.quantity,
                                add: () => cartController.addOneToCart(item),
                                remove: () =>
                                    cartController.removeOneFromCart(item),
                              ),
                              CProductpriceText(
                                price: (item.quantity * item.price)
                                    .toStringAsFixed(1),
                              ),
                            ],
                          ),
                          const SizedBox(height: CSizes.spaceBtwItems),
                          const Divider(),
                        ],
                      ),
                    )
                  ],
                )
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantity: ${item.quantity}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CProductpriceText(
                      price:
                          (item.quantity * item.price).toStringAsFixed(1),
                    ),
                  ],
                ),
                const SizedBox(height: CSizes.spaceBtwItems),
                const Divider(),
              ],
            ],
          );
        }),
      ),
    );
  }
}
