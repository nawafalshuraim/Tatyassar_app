import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:loom_store/data/repositories/user%20/user_repository.dart";
import "package:loom_store/features/personalization/controllers/user_controller.dart";
import "package:loom_store/navigation_menu.dart";
import "package:loom_store/utils/constants/image_strings.dart";
import "package:loom_store/utils/helpers/network_manager.dart";
import "package:loom_store/utils/popups/full_screen_loader.dart";
import "package:loom_store/utils/popups/loaders.dart";

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final userController = UserController.instance;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      CFullScreenLoader.openLoadingDialog(
          'We are updating your information...', CImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      CFullScreenLoader.stopLoading();

      // Show Success Message
      CLoaders.successSnackBar(
          title: 'Done', message: 'Your Name has been updated.');

      // Move to previous screen.
      //+ 
      await userController.fetchUserRecord();
      Get.off(() => const NavigationMenu());

      
      
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    }
  }
}
