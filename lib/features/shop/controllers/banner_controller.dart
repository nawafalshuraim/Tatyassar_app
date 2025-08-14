import 'package:get/get.dart';
import 'package:loom_store/data/repositories/banner/banner_repository.dart';
import 'package:loom_store/features/shop/models/banner_model.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class BannerController extends GetxController {

  final isLoading = false.obs;
  final carouselControllerIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel> [].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index){
    carouselControllerIndex.value = index;
  }

  // fetch banners 
  Future<void> fetchBanners() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // fetch banners 
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assing banners 
      this.banners.assignAll(banners);


    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
      
    }
  }
}

