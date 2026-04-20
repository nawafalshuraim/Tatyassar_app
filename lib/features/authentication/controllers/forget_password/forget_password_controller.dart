import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tatyassar/data/repositories/authentication/authentication_repository.dart';
import 'package:tatyassar/features/authentication/screens/passward_configuration/reset_passward.dart';
import 'package:tatyassar/utils/constants/image_strings.dart';
import 'package:tatyassar/utils/helpers/network_manager.dart';
import 'package:tatyassar/utils/popups/full_screen_loader.dart';
import 'package:tatyassar/utils/popups/loaders.dart';


class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password EMail
  sendPasswordResetEmail() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog(
          'Processing your request...', CImages.processingAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }
      // send the email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // remove loader
      CFullScreenLoader.stopLoading();

      // success message
      CLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password.'.tr);

      // redirect
      //Get.to(() => resendPasswordResetEmail(email.text.trim()));
      Get.to(() => ResetPassward(email: email.text.trim()));

    } catch (e) {
      // remove loader
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog(
          'Processing your request...', CImages.processingAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // send the email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // remove loader
      CFullScreenLoader.stopLoading();

      // success message
      CLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password.'.tr);
    } catch (e) {
      // remove loader
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    }
  }
}
