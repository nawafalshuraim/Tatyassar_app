import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/products/product_cards/product_card_vertical.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:loom_store/common/widgets/layout/grid_layout.dart';
import 'package:loom_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/shop/controllers/product_controller.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/features/shop/screens/all_products/all_products.dart';
import 'package:loom_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:loom_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:loom_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<ProductModel> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  void _searchProducts(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _searchResults.clear();
    });

    try {
      final lowerQuery = query.toLowerCase();

      final db = ProductController.instance.productRepository.db;

      // 🔹 First try fast prefix search
      QuerySnapshot snapshot = await db
          .collection('Products')
          .where('TitleLower', isGreaterThanOrEqualTo: lowerQuery)
          .where('TitleLower', isLessThanOrEqualTo: '$lowerQuery\uf8ff')
          .get();

      // If nothing found, try tokenized search (substring match)
      if (snapshot.docs.isEmpty) {
        snapshot = await db
            .collection('Products')
            .where('SearchTokens', arrayContains: lowerQuery)
            .get();
      }

      final results = snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      setState(() => _searchResults = results);
    } catch (e) {
      Get.snackbar('Error', 'Search failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults.clear();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: Column(
        children: [
          CPrimaryHeaderContainer(
            child: Column(
              children: [
                const CHomeAppBar(),
                const SizedBox(height: CSizes.spaceBtwSections / 2),

                // search bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CSizes.defaultSpace),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: TextField(
                      controller: _searchController,
                      // onSubmitted: _searchProducts,
                      onChanged: (query) {
                        if (query.trim().isEmpty) {
                          _clearSearch();
                        } else {
                          _searchProducts(query.trim());
                        }
                      },

                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                        icon: const Icon(Icons.search),
                        hintText:
                            'Find your service', // relationf in the product controller, repo...
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: _searchController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: _clearSearch,
                              ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: CSizes.spaceBtwSections / 2),
                const CSectionHeading(
                  title: '       LeanFIX Categories',
                  showActionButton: false,
                  textColor: Colors.white,
                ),
                const SizedBox(height: CSizes.spaceBtwItems),
                const CHomeCategories(),
                const SizedBox(height: CSizes.spaceBtwSections),
              ],
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(CSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CPromoSlider(),
                          const SizedBox(height: CSizes.spaceBtwSections),
                          // default content (categories, popular products)
                          CSectionHeading(
                            title: "Popular Services",
                            onPressed: () => Get.to(() => AllProducts(
                                  title: 'Popular Services',
                                  futureMethod:
                                      controller.fetchAllFeatureProducts(),
                                )),
                          ),
                          const SizedBox(height: CSizes.spaceBtwItems),
                          Obx(() {
                            if (controller.isLoading.value) {
                              return const CVerticalProductShimmer();
                            }
                            if (controller.featureProducts.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Data Found!',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }
                            return CGridLayout(
                              itemCount: controller.featureProducts.length,
                              itemBuilder: (_, index) => CProductCardVertical(
                                  product: controller.featureProducts[index]),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(CSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CSectionHeading(
                          title: "Search Results",
                          showActionButton: false,
                        ),
                        const SizedBox(height: CSizes.spaceBtwItems),
                        if (_isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (_searchResults.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Text('No matching found'),
                            ),
                          )
                        else
                          CGridLayout(
                            itemCount: _searchResults.length,
                            itemBuilder: (_, index) => CProductCardVertical(
                              product: _searchResults[index],
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
