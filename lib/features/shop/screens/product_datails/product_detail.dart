import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loom_store/common/products/cart/add_remove_button.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/features/shop/screens/checkout/checkout.dart';
import 'package:loom_store/features/shop/screens/product_datails/widgets/product_meta_data.dart';
import 'package:loom_store/features/shop/screens/product_datails/widgets/rating_share_widget.dart';
import 'package:loom_store/utils/constants/sizes.dart';


class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          showBackArrow: true),

      // products details
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) =>
              const SizedBox(height: CSizes.spaceBtwItems/1.5),
          itemCount: 4,
          itemBuilder: (_, index) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // rating and share
                        CRatingAndShare(),

                        // single product 
                        CProductMetaData(),
                        const SizedBox(height: CSizes.spaceBtwItems),

                        // add, remove, and total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CProductQuantityWithAddAndRemoveButton(),
                            CProductpriceText(price: '560'),
                          ],
                        ),
                         const SizedBox(height: CSizes.spaceBtwItems),
                         Divider(),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      // checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child:
            ElevatedButton(onPressed: () => Get.to(()=> const CheckoutScreen()), child: Text('Checkout SAR 560')),
      ),
    );
  }
}
