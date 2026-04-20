import 'package:flutter/material.dart';
import 'package:tatyassar/features/authentication/controllers/onboarding/onboarder_controller.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/device/device_utility.dart';
import 'package:tatyassar/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // this line calls Get.find();
    final controller = OnBoardingController.instance;
    //
    final dark = CHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: CDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: CSizes.defaultSpace, 
      child: SmoothPageIndicator(
        count:3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,

        effect: ExpandingDotsEffect( activeDotColor: dark ? CColors.primary: CColors.primary,dotHeight: 6),
      ),
    );
  }
}
