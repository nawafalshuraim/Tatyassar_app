import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/rounded_images/rounded_image.dart';
import 'package:loom_store/common/widgets/texts/product_title_text.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/features/shop/models/cart_item_model.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  bool isNetworkImage(String? url) {
    if (url == null) return false;
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        CRoundedContainer(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(CSizes.sm),
          backgroundColor: dark ? CColors.darkerGrey : CColors.light,
          child: CRoundImage(
            imageUrl: cartItem.image ?? '',
            isNetworkImage: isNetworkImage(cartItem.image),
            applyImageRadious: true,
          ),
        ),

        const SizedBox(width: CSizes.spaceBtwItems),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),
              
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              
              CProductpriceText(
                price: cartItem.price.toStringAsFixed(2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}