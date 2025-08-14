import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/features/authentication/screens/login/login.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/device/device_utility.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: CDeviceUtils.getAppBarHeight(),
      right: CSizes.defaultSpace,
      child: TextButton(
       onPressed: () => Get.to(LoginScreen()),
       child: const Text('Skip',style: TextStyle(color: CColors.primary),),
     )
   );
  }
}