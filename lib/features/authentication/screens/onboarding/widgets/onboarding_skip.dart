import 'package:flutter/material.dart';
import 'package:loom_store/features/authentication/controllers.onboarding/onboarder_controller.dart';
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
       onPressed: () => OnBoardingController.instance.skipPage(),
       child: const Text('Skip'),
     )
   );
  }
}