import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:loom_store/features/authentication/controllers/signup/singup_controller.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CTermsAndConditionsCheckbox extends StatelessWidget {
  const CTermsAndConditionsCheckbox({
    super.key,
   
  });


  @override
  Widget build(BuildContext context) {
    final controller = SingupController.instance;
    final dark = CHelperFunctions.isDarkMode(context);
    return Row(
    
      children: [
        // obx to rebuild
        SizedBox( width: 24, height: 24, child: Obx(() => Checkbox( value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
        const SizedBox(width:CSizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: '${CTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: CTexts.privacyPolicy, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? Colors.white : CColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? Colors.white : CColors.primary,
              )),
          
              TextSpan(text: ' ${CTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
              
              TextSpan(text: CTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? Colors.white : CColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? Colors.white : CColors.primary,
              )),
              ],   
          ),
          ),
        ),
      ],
    );
  }
}
