import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
import 'package:loom_store/utils/popups/loaders.dart'; 

class CCouponCode extends StatelessWidget {
  const CCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return CRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? CColors.dark : CColors.white,
      padding: EdgeInsets.only(
          bottom: CSizes.sm,
          top: CSizes.sm,
          left: CSizes.sm,
          right: CSizes.md),
      child: Row(
        children: [
          /// TextField
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? ',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ), 
            ), 
          ), 
    
          /// Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {
                // show error snackbar when Apply button tapped
                CLoaders.errorSnackBar(title: 'Error', message: 'Invalid coupon code.');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? CColors.white.withOpacity(0.5)
                    : CColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: const Text('Apply'),
            ), 
          ), 
        ],
      ),
    );
  }
}
