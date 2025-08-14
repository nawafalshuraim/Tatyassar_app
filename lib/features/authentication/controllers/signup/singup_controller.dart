import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/data/repositories/authentication/authentication_repository.dart';
import 'package:loom_store/data/repositories/user%20/user_repository.dart';
import 'package:loom_store/features/authentication/models/user_model.dart';
import 'package:loom_store/features/authentication/screens/signup/verify_email.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/helpers/network_manager.dart';
import 'package:loom_store/utils/popups/full_screen_loader.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class SingupController extends GetxController {
  static SingupController get instance => Get.find();

  //varibles
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final phoneNumber = TextEditingController();
  final privacyPolicy = true.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // form validation
      if (!signupFormKey.currentState!.validate()) return;

      // privacy policy check
      if (!privacyPolicy.value) {
        CLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create your account, you have to read and accept Policy & Terms of Use.');
        return;
      }

      // start loading AFTER all basic checks
      CFullScreenLoader.openLoadingDialog(
          'Your information are being processed', CImages.processingAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // register user to firebase authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // save authenticated user data in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      CFullScreenLoader.stopLoading();

      // success message
      CLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');

      // navigate to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    }
  }
}
