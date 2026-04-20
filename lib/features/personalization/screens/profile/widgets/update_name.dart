import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:tatyassar/data/repositories/user/user_repository.dart";
import "package:tatyassar/features/personalization/controllers/user_controller.dart";
import "package:tatyassar/navigation_menu.dart";
import "package:tatyassar/utils/constants/image_strings.dart";
import "package:tatyassar/utils/helpers/network_manager.dart";
import "package:tatyassar/utils/popups/full_screen_loader.dart";
import "package:tatyassar/utils/popups/loaders.dart";

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

      // Fetch & navigate first — overlay from the dialog is gone, show
      // the snackbar only after the new route's overlay is ready.
      await userController.fetchUserRecord();
      Get.offAll(() => const NavigationMenu());

      WidgetsBinding.instance.addPostFrameCallback((_) {
        CLoaders.successSnackBar(
            title: 'Done', message: 'Your Name has been updated.');
      });
    } catch (e) {
      CFullScreenLoader.stopLoading();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CLoaders.errorSnackBar(title: 'Error', message: e.toString());
      });
    }
  }
}
