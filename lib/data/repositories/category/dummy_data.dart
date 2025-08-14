import 'package:loom_store/features/shop/models/banner_model.dart';
import 'package:loom_store/features/shop/models/category_model.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/routs/routs.dart';
import 'package:loom_store/utils/constants/image_strings.dart';

class CDummyData {
  // Main Categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: CImages.productImage1, name: 'carpentery', isFeatured: true),
    CategoryModel(id: '5', image: CImages.productImage2, name: 'cleaning', isFeatured: true),
    CategoryModel(id: '2', image: CImages.productImage3, name: 'electricity', isFeatured: true),
    CategoryModel(id: '3', image: CImages.productImage4, name: 'flooring', isFeatured: true),
    CategoryModel(id: '4', image: CImages.productImage5, name: 'painting', isFeatured: true),
    CategoryModel(id: '6', image: CImages.productImage6, name: 'plumbing', isFeatured: true),
  ];

  // Subcategories (2 for each main category)
  static final List<CategoryModel> subCategories = [
    // Carpentry subcategories (parentId: '1')
    CategoryModel(id: '1-1', image: CImages.productImage1, name: 'Door Installation', isFeatured: false, parentId: '1'),
    CategoryModel(id: '1-2', image: CImages.productImage1, name: 'Cabinet Making', isFeatured: false, parentId: '1'),

    // Electricity subcategories (parentId: '2')
    CategoryModel(id: '2-1', image: CImages.productImage3, name: 'Outlet Installation', isFeatured: false, parentId: '2'),
    CategoryModel(id: '2-2', image: CImages.productImage3, name: 'Light Fixtures', isFeatured: false, parentId: '2'),

    // Flooring subcategories (parentId: '3')
    CategoryModel(id: '3-1', image: CImages.productImage4, name: 'Tile Installation', isFeatured: false, parentId: '3'),
    CategoryModel(id: '3-2', image: CImages.productImage4, name: 'Laminate Flooring', isFeatured: false, parentId: '3'),

    // Painting subcategories (parentId: '4')
    CategoryModel(id: '4-1', image: CImages.productImage5, name: 'Interior Painting', isFeatured: false, parentId: '4'),
    CategoryModel(id: '4-2', image: CImages.productImage5, name: 'Exterior Painting', isFeatured: false, parentId: '4'),

    // Cleaning subcategories (parentId: '5')
    CategoryModel(id: '5-1', image: CImages.productImage2, name: 'Deep Cleaning', isFeatured: false, parentId: '5'),
    CategoryModel(id: '5-2', image: CImages.productImage2, name: 'Window Cleaning', isFeatured: false, parentId: '5'),

    // Plumbing subcategories (parentId: '6')
    CategoryModel(id: '6-1', image: CImages.productImage6, name: 'Pipe Repair', isFeatured: false, parentId: '6'),
    CategoryModel(id: '6-2', image: CImages.productImage6, name: 'Faucet Installation', isFeatured: false, parentId: '6'),
  ];

  // Banners
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: CImages.promoBanner1, targetScreen: CRoutes.home, active: true),
    BannerModel(imageUrl: CImages.promoBanner2, targetScreen: CRoutes.home, active: true),
    BannerModel(imageUrl: CImages.promoBanner3, targetScreen: CRoutes.home, active: true),
  ];

  // Products - including one variable product with variations
  static final List<ProductModel> products = [
    ProductModel(
      id: '1',
      title: 'Installation of Door Frame',
      stock: 10,
      price: 100,
      salePrice: 90,
      thumbnail: CImages.productImage1,
      isFeatured: true,
      categoryId: '1-1',
      description: 'Install a standard interior or exterior door frame.',
      productType: ProductType.single.name,
    ),
    ProductModel(
      id: '2',
      title: 'Change Electrical Outlet',
      stock: 8,
      price: 29,
      salePrice: 22,
      thumbnail: CImages.productImage3,
      isFeatured: true,
      categoryId: '2-1',
      description: 'Replace an old or broken power outlet.',
      productType: ProductType.single.name,
    ),
    ProductModel(
      id: '3',
      title: 'Flooring 3x3 Room (Variable)',
      stock: 15,
      price: 0, // base price 0 for variable product
      salePrice: 0,
      thumbnail: CImages.productImage4,
      isFeatured: true,
      categoryId: '3-2',
      description: 'Choose your preferred flooring type and size.',
      productType: ProductType.variable.name,
      productVariations: [
        ProductVariationModel(id: 'v1', price: 180, salePrice: 160),
        ProductVariationModel(id: 'v2', price: 200, salePrice: 170),
        ProductVariationModel(id: 'v3', price: 220, salePrice: 190),
      ],
    ),
    // Other single products...
    ProductModel(
      id: '4',
      title: 'Deep Cleaning 3x3 Room',
      stock: 9,
      price: 175,
      salePrice: 125,
      thumbnail: CImages.productImage2,
      isFeatured: true,
      categoryId: '5-1',
      description: 'Including floors, walls, and surfaces.',
      productType: ProductType.single.name,
    ),
    // Add more as needed...
  ];

  // Helpers
  static List<CategoryModel> getSubCategoriesByParentId(String parentId) =>
      subCategories.where((subCat) => subCat.parentId == parentId).toList();

  static List<CategoryModel> getAllCategories() => [...categories, ...subCategories];
}
