import 'package:flutter/material.dart';
import 'package:loom_store/common/products/add_to_cart_button.dart';
import 'package:loom_store/common/styles/shadow.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/rounded_images/rounded_image.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/common/widgets/texts/product_title_text.dart';
import 'package:loom_store/features/shop/controllers/product_controller.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
// Using Unicode Saudi Riyal symbol directly

class CProductCardVertical extends StatelessWidget {
  const CProductCardVertical({super.key, required this.product});

  final ProductModel product;
  static const String Saudi_Riyal_Symbol =
    "assets/icons/currency/Saudi_Riyal_Symbol.png";


  // Helper method to detect if image is network URL or local asset path
  bool isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          boxShadow: [CShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? const Color.fromARGB(255, 59, 59, 59) : CColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail section
            CRoundedContainer(
              width: 160,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.light,
              child: Stack(
                children: [
                  CRoundImage(
                    imageUrl: product.thumbnail,
                    applyImageRadious: true,
                    isNetworkImage: isNetworkImage(product.thumbnail),
                  ),

                  // Sale tag (only if salePercentage is not null)
                  if (salePercentage != null)
                    CRoundedContainer(
                      radius: CSizes.sm,
                      backgroundColor: CColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: CSizes.sm, vertical: CSizes.xs),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: CColors.black),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwItems / 2),

            // Product details: title and description
            Padding(
              padding: const EdgeInsets.only(left: CSizes.sm, right: CSizes.sm),
              child: Column(
                children: [
                  CProductTitleText(title: product.title),
                  const SizedBox(height: CSizes.spaceBtwItems),
                  Text(
                    product.description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: CSizes.spaceBtwItems / 2),
                ],
              ),
            ),

            const Spacer(),

            // Price and add button row
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.salePrice > 0)
            Padding(
              padding: const EdgeInsets.only(left: CSizes.sm),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/currency/Saudi_Riyal_Symbol.png',
                    width: 12, // Smaller for strikethrough price
                    height: 12,
                    color: Colors.grey, 

                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ),
          Padding(
  padding: const EdgeInsets.only(left: CSizes.sm),
  child: CProductpriceText(
    price: controller.getProductPrice(product),
  ),
),
        ],
      ),
    ),
    // add to cart button
    ProductCardAddToCartButton(product: product)
  ],
)
          ],
        ),
      ),
    );
  }
}