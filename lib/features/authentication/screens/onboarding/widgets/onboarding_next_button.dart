import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/authentication/controllers.onboarding/onboarder_controller.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/device/device_utility.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

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
        style: ElevatedButton.styleFrom(shape: CircleBorder(), backgroundColor: dark ? CColors.primary : Colors.black, side: const BorderSide(color: Colors.black)),
        child: Icon(Iconsax.arrow_right_3, color: Colors.white,),
        )
    );
  }
}