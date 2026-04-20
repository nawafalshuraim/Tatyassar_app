import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatyassar/data/repositories/authentication/authentication_repository.dart';
import 'package:tatyassar/features/personalization/controllers/user_controller.dart';
import 'package:tatyassar/utils/constants/image_strings.dart';
import 'package:tatyassar/utils/helpers/network_manager.dart';
import 'package:tatyassar/utils/popups/full_screen_loader.dart';
import 'package:tatyassar/utils/popups/loaders.dart';


class LoginController extends GetxController {
  // variables
  // obs observed by obx in which there is no need for stateful, rebuild specific parts of the form only like the TextFormField
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = true.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // Fix: Handle null values from GetStorage by providing default empty strings
    // addeded //
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

// email & password SignIn
  Future<void> emailAndPasswordSignIn(dynamic signupFormKey) async {
    try {
      // start loading
      CFullScreenLoader.openLoadingDialog('Logging you in...', CImages.processingAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // remove loader
        CFullScreenLoader.stopLoading();
        // Add return statement or show error message
        CLoaders.errorSnackBar(
            title: 'Connection Error', message: 'No internet connection');
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        // remove loader
        CFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login authentication
      final userCredential = await AuthenticationRepository.instance
          .LoginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      CFullScreenLoader.stopLoading();

      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // remove loader
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

// google SignIn
  Future<void> googleSignIn() async {
    try {
      // Start loader
      CFullScreenLoader.openLoadingDialog(
          'Logging you in...', CImages.processingAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        CLoaders.errorSnackBar(
            title: 'Connection Error', message: 'No internet connection');
        return;
      }

      // Sign in with Google
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save user record — UserController is created here, after auth succeeds
      final userController = Get.put(UserController());
      await userController.saveUserRecord(userCredentials);

      // Stop loader and redirect
      CFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}



