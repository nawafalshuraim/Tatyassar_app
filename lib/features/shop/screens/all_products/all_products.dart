import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/products/checkout_cart/cart_menu_icon.dart';
import 'package:loom_store/common/products/sortable_products.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:loom_store/features/shop/controllers/all_products_controller.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/features/shop/screens/cart/cart.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/cloud_helper_functions.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    final isDarkMode = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      /// AppBar
      appBar: CAppBar(title: Text(title), showBackArrow: true, actions: [
        CCartCounterIcon(
          onPressed: () => CartScreen(),
          iconColor: isDarkMode ? CColors.white : CColors.black,
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // check the state of the FutureBuilder snapshot
              const loader = CVerticalProductShimmer();
              final widget = CCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);

              if (widget != null) return widget;

              // Products found!
              final products = snapshot.data!;

              return CSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
