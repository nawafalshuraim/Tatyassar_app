import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/features/shop/controllers/cart_controller.dart';
import 'package:loom_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:loom_store/features/shop/screens/checkout/checkout.dart';
import 'package:loom_store/navigation_menu.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/loaders/animation_loader.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: CAppBar(
        title: Text('cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        
        // Add delete icon button conditionally
        actions: [
          Obx(() {
            if (controller.cartItems.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Clear Cart',
                onPressed: () {
                  // Confirm before clearing cart
                  Get.defaultDialog(
                    title: 'Clear Cart',
                    middleText:
                        'Are you sure you want to remove all cart items?',
                    barrierDismissible: false, // prevent dismiss on outside tap
                    onConfirm: () {
                      controller.clearCart();
                      Get.back();
                      CLoaders.customToast(message: 'Cart cleared.');
                    },
                    // Remove Get.back() from onCancel - dialog dismisses automatically
                    onCancel: () {
                      // Dialog will close automatically, no need to call Get.back()
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),

      body: Obx(
        () {
          /// Nothing Found Widget
          final emptyWidget = CAnimationLoaderWidget(
            text: 'Cart is EMPTY!',
            animation: CImages.processingAnimation,
            showAction: true,
            actionText: 'FILL IT',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(CSizes.defaultSpace),
                // items in Cart
                child: CCartItems(),
              ),
            );
          }
        },
      ),

      // checkout button
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const SizedBox();
        } else {
          return Padding(
            padding: const EdgeInsets.all(CSizes.defaultSpace),
            child: ElevatedButton(
  onPressed: () => Get.to(() => const CheckoutScreen()),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Checkout '),
      Image.asset(
        'assets/icons/currency/Saudi_Riyal_Symbol.png',
        width: 16,
        height: 16,
        color: Colors.white,
      ),
      const SizedBox(width: 4),
      Text('${controller.totalCartPrice.value}'),
    ],
  ),
),
          );
        }
      }),
    );
  }
}