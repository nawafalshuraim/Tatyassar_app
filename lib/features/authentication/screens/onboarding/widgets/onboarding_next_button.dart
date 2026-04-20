import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatyassar/features/authentication/controllers/onboarding/onboarder_controller.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/device/device_utility.dart';
import 'package:tatyassar/utils/helpers/helper_functions.dart';

class OnBoaringNextButton extends StatelessWidget {
  const OnBoaringNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Positioned(
      right: CSizes.defaultSpace,
      bottom: CDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: CircleBorder(), backgroundColor: dark ? CColors.primary : CColors.primary),
        child: Icon(Iconsax.arrow_right_1, color: Colors.white,),
        )
    );
  }
}