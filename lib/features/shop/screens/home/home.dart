import 'package:flutter/material.dart';
import 'package:loom_store/common/products/product_cards/product_card_vertical.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:loom_store/common/widgets/layout/grid_layout.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:loom_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:loom_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ** HEADER **
            const CPrimaryHeaderContainer(
              child: Column(
                children: [
                  // appbar
                  CHomeAppBar(),

                  SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  // searchbar
                  CSearchContainer(
                    text: 'I want to hire a...',
                  ),
                  SizedBox(height: CSizes.spaceBtwSections),

                  // heading
                  CSectionHeading(
                      title: '       LeanFIX Catogories',
                      showActionButton: false,
                      textColor: Colors.white),
                  SizedBox(height: CSizes.spaceBtwItems),

                  // categories
                  CHomeCategories(),

                  SizedBox(height: CSizes.spaceBtwSections,)

                ],
              ),
            ),

            // ** BODY *
            Padding(
              // banner sliders
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  const CPromoSlider(
                    banners: [
                      CImages.banner1,
                      CImages.banner2,
                      CImages.banner3
                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtwSections),

                  // heading
                  CSectionHeading(
                    title: "LeanFIX Services",
                    onPressed: () {},
                  ),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  // products
                  CGridLayout(
                      itemCount: 8,
                      itemBuilder: (_, index) => const CProductCardVertical())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
