import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tatyassar/common/widgets/login_signup/success_screen.dart/success_screen.dart';
import 'package:tatyassar/data/repositories/authentication/authentication_repository.dart';
import 'package:tatyassar/utils/constants/image_strings.dart';
import 'package:tatyassar/utils/constants/text_strings.dart';
import 'package:tatyassar/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // send email once verify screen appears and set time for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      CLoaders.successSnackBar(
          title: 'Email Sent ',
          message: 'Please check your inbox and verify your email');
    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    }
  }

  // time to auto redirect on email verification
  setTimerForAutoRedirect() {
    // after how many time units you want to excute the timer function
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final User = FirebaseAuth.instance.currentUser;
      if (User?.emailVerified ?? false) {
        timer.cancel();
        // Get.off() menas destroy the previous page
        Get.off(
          () => SuccessScreen(
              image: CImages.staticSuccessIllustration,
              title: CTexts.yourAccountCreatedTitle,
              subtitle: CTexts.yourAccountCreatedSubTitle,
              // screenRedirect() decide to go to login screen or you do not
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect()),
        );
      }
    });
  }

  // manually checl if the email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
            image: CImages.staticSuccessIllustration,
            title: CTexts.yourAccountCreatedTitle,
            subtitle: CTexts.yourAccountCreatedSubTitle,
            // screenRedirect() decide to go to login screen or you do not
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()),
      );
    }
  }
}
