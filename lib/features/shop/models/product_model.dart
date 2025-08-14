import 'package:cloud_firestore/cloud_firestore.dart';

// ENUM --------------------------
enum ProductType { single, variable }

// VARIATION MODEL ----------------
class ProductVariationModel {
  String? id;
  double price;
  double salePrice;

  ProductVariationModel({
    this.id,
    required this.price,
    this.salePrice = 0.0,
  });

  factory ProductVariationModel.fromMap(Map<String, dynamic> data) {
    return ProductVariationModel(
      id: data['Id'],
      price: double.tryParse(data['Price']?.toString() ?? '0.0') ?? 0.0,
      salePrice: double.tryParse(data['SalePrice']?.toString() ?? '0.0') ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Price': price,
      'SalePrice': salePrice,
    };
  }
}

// PRODUCT MODEL -------------------
class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  String? description;
  String? categoryId;
  String productType;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.productVariations,
    this.sku,
    this.date,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        price: 0.0,
        thumbnail: '',
        productType: ProductType.single.name,
        productVariations: [],
      );

  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Description': description,
      'ProductType': productType,
      'Variations': productVariations?.map((e) => e.toMap()).toList(),
      'Date': date?.toIso8601String(),
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return ProductModel.empty();

    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.tryParse(data['Price']?.toString() ?? '0.0') ?? 0.0,
      salePrice: double.tryParse(data['SalePrice']?.toString() ?? '0.0') ?? 0.0,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? ProductType.single.name,
      productVariations: (data['Variations'] as List<dynamic>?)
              ?.map((e) => ProductVariationModel.fromMap(e))
              .toList() ??
          [],
      date: data['Date'] != null ? DateTime.tryParse(data['Date']) : null,
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.tryParse(data['Price']?.toString() ?? '0.0') ?? 0.0,
      salePrice: double.tryParse(data['SalePrice']?.toString() ?? '0.0') ?? 0.0,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? ProductType.single.name,
      productVariations: (data['Variations'] as List<dynamic>?)
              ?.map((e) => ProductVariationModel.fromMap(e))
              .toList() ??
          [],
      date: data['Date'] != null ? DateTime.tryParse(data['Date']) : null,
    );
  }
}
