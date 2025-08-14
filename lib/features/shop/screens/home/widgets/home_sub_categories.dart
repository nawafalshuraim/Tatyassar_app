import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/products/checkout_cart/cart_menu_icon.dart';
import 'package:loom_store/common/products/product_cards/product_card_horizontal.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/shop/controllers/category_controller.dart';
import 'package:loom_store/features/shop/models/category_model.dart';
import 'package:loom_store/features/shop/screens/all_products/all_products.dart';
import 'package:loom_store/features/shop/screens/cart/cart.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/cloud_helper_functions.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final isDarkMode = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CAppBar(
        title: Text(category.name),
        showBackArrow: true,
        actions: [
          CCartCounterIcon(
            onPressed: () => CartScreen(),
            iconColor: isDarkMode ? CColors.white : CColors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              /// Promo Banner
              // const CRoundImage(
              //   width: double.infinity,
              //   imageUrl: CImages.promoBanner1,
              //   applyImageRadious: true,
              // ),
              //const SizedBox(height: CSizes.spaceBtwSections),

              /// Sub-Categories List
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  // Loader or empty/error state
                  const loader = CHorizontalProductShimmer();
                  final widget = CCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  // Record found
                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subCategories.length,
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          final widget =
                              CCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: loader,
                          );
                          if (widget != null) return widget;

                          final products = snapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Subcategory Heading
                              CSectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                  () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod:
                                        controller.getCategoryProducts(
                                      categoryId: subCategory.id,
                                      limit: -1,
                                    ),
                                  ),
                                ),
                              ),

                              /// Product List (Horizontal)
                              SizedBox(
                                height: 200,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 20),
                                  itemBuilder: (context, index) => SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: CProductCardHorizontal(
                                        product: products[index]),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
