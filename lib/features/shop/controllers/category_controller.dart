
import 'package:get/get.dart';
import 'package:loom_store/data/repositories/category/category_repositroy.dart';
import 'package:loom_store/data/repositories/product/product_repository.dart';
import 'package:loom_store/features/shop/models/category_model.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/popups/loaders.dart';

// control repo

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }


  /// categories
  Future<void> fetchCategories() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // fetch categories from data source (Firestore, API, etc.)--------------------------
      final categories = await _categoryRepository.getAllCategories();

      // update the categories list
      allCategories.assignAll(categories);

      // filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());

    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  /// Load selected category data
Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  
  try {
    final subcategories = await _categoryRepository.getSubCategories(categoryId);
    return subcategories;
  } catch (e) {
    CLoaders.errorSnackBar(title: '!', message: e.toString());
    return [];
  }
}

/// Get Category or Sub-Category Products.
Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
  try {
    // Fetch limited (4) products against each subcategory;
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  } catch (e) {
    CLoaders.errorSnackBar(title: '!', message: e.toString());
    return [];
  }
}
}