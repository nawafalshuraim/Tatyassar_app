import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loom_store/features/shop/models/category_model.dart';
import 'package:loom_store/utils/exceptions/firebase_exceptions.dart';
import 'package:loom_store/utils/exceptions/firebase_storage_service.dart';
import 'package:loom_store/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// variables
  final _db = FirebaseFirestore.instance;

  /// get  categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// get sub-categories
Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  try {
    
    final snapshot = await _db.collection("Categories").where('ParentId', isEqualTo: categoryId).get();
    final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
    return result;
    
  } on FirebaseException catch (e) {
    throw CFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw CPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}



///  upload dummy data (for the time being til the admin panel is ready) - I used button in home.dart to start the process
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(CFirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('Categories', file, category.name);

        // Assign URL to Category.image attribute
        category.image = url;

        // Store Category in Firestore
        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
