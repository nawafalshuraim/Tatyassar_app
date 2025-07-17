import 'package:flutter/material.dart';
import 'package:loom_store/common/styles/spacing_styles.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});

  final String image,title,subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [

              //image
              Image(image: AssetImage(image), width: CHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: CSizes.spaceBtwSections),

              //title and subtitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems), 
              Text(subtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwSections), 

              //button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: const Text(CTexts.CContinue))),
            ],
            

          ),
        ),
      ),
    );
  }
}