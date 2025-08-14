import 'package:get/get.dart';
import 'package:loom_store/data/repositories/product/product_repository.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit(); // Call super.onInit() first
    fetchFeatureProducts();
  }

  @override
  void onReady() {
    super.onReady();
    // Additional initialization if needed
  }

  void fetchFeatureProducts() async {
    try {
      isLoading.value = true;

      // fetch products
      final products = await productRepository.getFeaturedProducts();

      // assign products
      featureProducts.assignAll(products);
    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeatureProducts() async {
    try {
      // fetch products
      final products = await productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: e.toString());
      return [];
    }
  }

  /// Get the product price or sale price (if available) - UPDATED WITH SAR CURRENCY
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.toString()) {
      double price = product.salePrice > 0 ? product.salePrice : product.price;
      return ' ${price.toStringAsFixed(2)}'; // CHANGED: $ to SAR
    } else {
      // FIXED: Check if productVariations is not null and not empty
      if (product.productVariations == null ||
          product.productVariations!.isEmpty) {
        // Fallback to regular price if no variations
        double price =
            product.salePrice > 0 ? product.salePrice : product.price;
        return ' ${price.toStringAsFixed(2)}'; // CHANGED: $ to SAR
      }

      // Calculate prices from variations
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0 ? variation.salePrice : variation.price;
        if (priceToConsider < smallestPrice) smallestPrice = priceToConsider;
        if (priceToConsider > largestPrice) largestPrice = priceToConsider;
      }

      // FIXED: Check if we found valid prices
      if (smallestPrice == double.infinity) {
        // Fallback to regular price if variations don't have valid prices
        double price =
            product.salePrice > 0 ? product.salePrice : product.price;
        return ' ${price.toStringAsFixed(2)}'; // CHANGED: $ to SAR
      }

      return (smallestPrice == largestPrice)
          ? ' ${smallestPrice.toStringAsFixed(2)}'
          : ' ${smallestPrice.toStringAsFixed(2)} - ${largestPrice.toStringAsFixed(2)}'; // FIXED: Removed duplicate SAR
    }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  String getProductAvailabilityStatus(int stock) {
    return stock > 0 ? 'Available' : 'Not Available';
  }

  // ** home screen search bar related **
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      if (query.isEmpty) return [];
      return await productRepository.searchProductsByTitle(query);
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Search Error', message: e.toString());
      return [];
    }
  }

  Future<void> triggerSearchTokenMigration() async {
  try {
    await productRepository.migrateProductsWithSearchTokens();
    CLoaders.successSnackBar(
      title: 'Migration Complete', 
      message: 'All products now support improved search!'
    );
  } catch (e) {
    CLoaders.errorSnackBar(
      title: 'Migration Failed', 
      message: e.toString()
    );
  }
}
}