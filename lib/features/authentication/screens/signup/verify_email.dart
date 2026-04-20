import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tatyassar/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:tatyassar/utils/constants/image_strings.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/constants/text_strings.dart';
import 'package:tatyassar/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        // hide defult back arrow
        automaticallyImplyLeading: false,
        actions: [
          // IconButton(
          //     onPressed: () => AuthenticationRepository.instance.logout(),
          //     icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              //image
              Image(
                image: AssetImage(CImages.deliveredEmailIllustration),
                width: CHelperFunctions.screenWidth() * 0.6,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              //title and subtitle
              Text(CTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(CTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwSections),

              //button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.checkEmailVerificationStatus(),
                      child: const Text(CTexts.CContinue))),

              const SizedBox(height: CSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(), child: const Text(CTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
