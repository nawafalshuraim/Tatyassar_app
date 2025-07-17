import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loom_store/common/widgets/login_signup/success_screen.dart/success_screen.dart';
import 'package:loom_store/features/authentication/screens/login/login.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // hide defult back arrow
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> Get.offAll(()=> LoginScreen()), icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace), 
          child: Column(
            children: [

              //image
              Image(image: AssetImage(CImages.deliveredEmailIllustration), width: CHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: CSizes.spaceBtwSections),

              //title and subtitle
              Text(CTexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems), 
              Text("Support@nawaf.com", style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems), 
              Text(CTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
             const SizedBox(height: CSizes.spaceBtwSections), 

              //button
              SizedBox(
               width: double.infinity, 
               child: ElevatedButton(
                onPressed: ()=> Get.to(()=> SuccessScreen(
                 image: CImages.staticSuccessIllustration,
                 title: CTexts.yourAccountCreatedTitle, 
                 subtitle: CTexts.yourAccountCreatedSubTitle, 
                 onPressed: ()=> Get.to(()=> const LoginScreen()),

                )),

                 child: const Text(CTexts.CContinue))),

              const SizedBox(height: CSizes.spaceBtwItems), 
              SizedBox(width: double.infinity, child: TextButton(onPressed: (){}, child: const Text(CTexts.resendEmail))),
            ],
          ),

        ),
      ),
    );
  }
}