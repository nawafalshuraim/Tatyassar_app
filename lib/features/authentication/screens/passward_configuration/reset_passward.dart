import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loom_store/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:loom_store/features/authentication/screens/login/login.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';


class ResetPassward extends StatelessWidget {
  const ResetPassward({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // image with 0.6 of the screen width
              Image(image: AssetImage(CImages.deliveredEmailIllustration), width: CHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: CSizes.spaceBtwSections),

              // title and subtitle
              Text(CTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems), 
              Text(CTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwSections), 

              //buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => LoginScreen()), child: const Text(CTexts.done))),
              const SizedBox(height: CSizes.spaceBtwItems), 
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text(CTexts.resendEmail))),


            ],
          ),
        ),
      )
     );
  }
}