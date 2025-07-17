import 'package:flutter/material.dart';
import 'package:loom_store/common/products/cart/add_remove_button.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/features/shop/screens/product_datails/widgets/product_meta_data.dart';
import 'package:loom_store/features/shop/screens/product_datails/widgets/rating_share_widget.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CCartItems extends StatelessWidget {
  const CCartItems({
    super.key, this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          const SizedBox(height: CSizes.spaceBtwItems / 1.5),
      itemCount: 4,
      itemBuilder: (_, index) => Column(
        children: [

          //items to in the checkout screen
          const CProductMetaData(),
          if(showAddRemoveButtons) const SizedBox(height: CSizes.spaceBtwItems),

          if(showAddRemoveButtons) 
          const Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // rating and share
                    CRatingAndShare(),
                    CProductMetaData(),
                    SizedBox(height: CSizes.spaceBtwItems),

                    // add, remove, and total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CProductQuantityWithAddAndRemoveButton(),
                        CProductpriceText(price: '560'),
                      ],
                    ),
                    SizedBox(height: CSizes.spaceBtwItems),
                    Divider(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
