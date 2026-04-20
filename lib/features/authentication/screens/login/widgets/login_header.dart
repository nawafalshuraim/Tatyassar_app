import 'package:flutter/material.dart';
import 'package:tatyassar/utils/constants/image_strings.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/constants/text_strings.dart';
import 'package:tatyassar/utils/helpers/helper_functions.dart';

class CLoginHeader extends StatelessWidget {
  const CLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return Align(
      alignment: Alignment.centerLeft, // Entire block sticks to the left
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Children align left
          mainAxisSize: MainAxisSize.min,
          children: [
            // fixed-size image
            SizedBox(
              height: 90,
              width: 90,
              child: Image.asset(
                dark ? CImages.lightAppLogo : CImages.darkAppLogo,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwItems),

            // title
            Text(
              CTexts.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: CSizes.sm),

            // subtitle
            Text(
              CTexts.loginSubTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
