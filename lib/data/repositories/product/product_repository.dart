import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/exceptions/firebase_exceptions.dart';
import 'package:loom_store/utils/exceptions/platform_exceptions.dart';

// Repository for managing product-related data and operations.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;
  
  // ** home screen search bar related **
  FirebaseFirestore get db => _db;

  // get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get products based on...
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract productIds from the documents
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Extract brand names or other relevant data from the documents
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// **************** home screen search bar related ****************


/// Upload dummy products to Firebase for case insensetive
//    Future<void> uploadDummyProducts(List<ProductModel> products) async {
//   try {
//     final batch = _db.batch();

//     for (var product in products) {
//       final docRef = _db.collection("Products").doc();

//       // Convert to map
//       final productData = product.toJson();

//       // 🔹CASE-INSENSITIVE SEARCH FIX:
//       // Store a lowercase version of the title for case-insensitive search
//       productData['TitleLower'] = product.title.toLowerCase();

//       batch.set(docRef, productData);
//     }

//     await batch.commit();
//   } catch (e) {
//     throw 'Failed to upload dummy products: $e';
//   }
// }
/// Upload dummy products to Firebase for search tokens
// Future<void> uploadDummyProducts(List<ProductModel> products) async {
//   try {
//     final batch = _db.batch();

//     for (var product in products) {
//       final docRef = _db.collection("Products").doc();
//       final productData = product.toJson();
      
//       // Create search tokens for better substring matching
//       productData['TitleLower'] = product.title.toLowerCase();
//       productData['SearchTokens'] = _createSearchTokens(product.title);
      
//       batch.set(docRef, productData);
//     }

//     await batch.commit();
//   } catch (e) {
//     throw 'Failed to upload dummy products: $e';
//   }
// }

/// helper method to create search tokens
List<String> _createSearchTokens(String title) {
  final tokens = <String>{};
  final words = title.toLowerCase().split(' ');
  
  for (String word in words) {
    // Add the full word
    tokens.add(word);
    
    // Add all substrings of length 2 or more
    for (int i = 0; i < word.length; i++) {
      for (int j = i + 2; j <= word.length; j++) {
        tokens.add(word.substring(i, j));
      }
    }
  }
  
  return tokens.toList();
}

Future<List<ProductModel>> searchProductsByTitle(String title) async {
  try {
    final query = title.toLowerCase().trim();
    if (query.isEmpty) return [];
    
    final snapshot = await _db
        .collection('Products')
        .where('SearchTokens', arrayContains: query)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromQuerySnapshot(doc))
        .toList();
  } on FirebaseException catch (e) {
    throw CFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw CPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong during search. Please try again';
  }
}


/// Search products by title (case-insensitive prefix match)
// Future<List<ProductModel>> searchProductsByTitle(String title) async {
//   try {
//     final lowerQuery = title.toLowerCase(); // 🔹 Convert search text to lowercase

//     final snapshot = await _db
//         .collection('Products')
//         .where('TitleLower', isGreaterThanOrEqualTo: lowerQuery)
//         .where('TitleLower', isLessThanOrEqualTo: '$lowerQuery\uf8ff')
//         .get();

//     return snapshot.docs
//         .map((doc) => ProductModel.fromQuerySnapshot(doc))
//         .toList();
//   } on FirebaseException catch (e) {
//     throw CFirebaseException(e.code).message;
//   } on PlatformException catch (e) {
//     throw CPlatformException(e.code).message;
//   } catch (e) {
//     throw 'Something went wrong during search. Please try again';
//   }
// }


// // migration method for existing products:
Future<void> migrateProductsWithSearchTokens() async {
  try {
    final snapshot = await _db.collection('Products').get();
    final batch = _db.batch();
    
    for (var doc in snapshot.docs) {
      final title = doc['Title'];
      if (title != null) {
        batch.update(doc.reference, {
          'TitleLower': title.toString().toLowerCase(),
          'SearchTokens': _createSearchTokens(title.toString()),
        });
      }
    }
    
    await batch.commit();
    print("Migration completed: All products have search tokens.");
  } catch (e) {
    throw 'Migration failed: $e';
  }
}

}
