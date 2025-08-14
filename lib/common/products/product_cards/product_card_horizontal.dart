import 'package:flutter/material.dart';
import 'package:loom_store/common/products/add_to_cart_button.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/rounded_images/rounded_image.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/common/widgets/texts/product_title_text.dart';
import 'package:loom_store/features/shop/controllers/product_controller.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CProductCardHorizontal extends StatelessWidget {
  const CProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      padding: const EdgeInsets.all(CSizes.sm),
      decoration: BoxDecoration(
        //boxShadow: [CShadowStyle.horizontalProductShadow],
        color: dark
            ? const Color.fromARGB(255, 59, 59, 59)
            : const Color.fromARGB(255, 251, 251, 251),
        borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
      ),
      child: Row(
        children: [
          /// --- Product Image
          Stack(
            children: [
              CRoundedContainer(
                width: 120,
                height: 120,
                backgroundColor: dark
                    ? const Color.fromARGB(255, 45, 45, 45)
                    : const Color.fromARGB(255, 245, 245, 245),
                child: Center(
                  child: CRoundImage(
                    imageUrl: product.thumbnail,
                    width: 100,
                    height: 100,
                    isNetworkImage: true,
                  ),
                ),
              ),

              /// --- Sale Tag
              if (salePercentage != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: CRoundedContainer(
                    radius: CSizes.sm,
                    backgroundColor: CColors.secondary.withOpacity(0.9),
                    padding: const EdgeInsets.symmetric(
                      horizontal: CSizes.sm,
                      vertical: CSizes.xs,
                    ),
                    child: Text(
                      '$salePercentage%',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: CColors.black),
                    ),
                  ),
                )
            ],
          ),

          const SizedBox(width: CSizes.spaceBtwItems),

          /// --- Product Info Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CProductTitleText(title: product.title),
                  const SizedBox(height: CSizes.spaceBtwItems / 2),

                  /// Description
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  const SizedBox(height: CSizes.spaceBtwItems),

                  /// Prices and Add Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Price Column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.salePrice > 0)
                            CProductpriceText(
                              price: '${product.price.toStringAsFixed(2)}',
                              lineThrough: true,
                              isLarge: false,
                            ),
                          CProductpriceText(
                            price: controller.getProductPrice(product),
                          ),
                        ],
                      ),

                      /// Add Button to cart
                      ProductCardAddToCartButton(product: product)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
