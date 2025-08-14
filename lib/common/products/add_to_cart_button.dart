import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/shop/controllers/cart_controller.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        final cartItem = cartController.convertToCartItem(product, 1);
        cartController.addOneToCart(cartItem);
      },
      child: Obx(
        () {
          final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? const Color.fromARGB(255, 201, 14, 14) : //CColors.dark 
              CColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(CSizes.cardRadiusMd),
                bottomRight: Radius.circular(CSizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              width: CSizes.iconLg * 1.2,
              height: CSizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.white))
                : const Icon(Iconsax.add, color: CColors.white)),

            ),
          );
        },
      ),
    );
  }
}
