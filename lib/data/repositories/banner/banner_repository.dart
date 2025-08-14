import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loom_store/features/shop/models/banner_model.dart';
import 'package:loom_store/utils/exceptions/firebase_exceptions.dart';
import 'package:loom_store/utils/exceptions/firebase_storage_service.dart';
import 'package:loom_store/utils/exceptions/format_exceptions.dart';
import 'package:loom_store/utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current User
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on CFirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }

  ///  upload dummy data (for the time being till the admin panel is ready) - I used button in home.dart to start the process
  Future<void> uploadDummyBanners(List<BannerModel> banners) async {
    try {
      final storage = Get.put(CFirebaseStorageService());

      for (int i = 0; i < banners.length; i++) {
  final banner = banners[i];
  final file = await storage.getImageDataFromAssets(banner.imageUrl);
  
  // Unique filename per banner by appending index
  final url = await storage.uploadImageData('Banners', file, 'banner_$i');
  
  banner.imageUrl = url;
  await _db.collection("Banners").add(banner.toJson());
}
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while uploading banners.';
    }
  }
}
