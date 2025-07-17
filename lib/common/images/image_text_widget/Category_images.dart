
import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CVerticalImageText extends StatelessWidget {
  const CVerticalImageText({
    super.key, 
    required this.image, 
    required this.title, 
    this.textColor = CColors.white,
    this.backgroundColor = CColors.white,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: CSizes.spaceBtwItems),

        child: Column(
          children: [
            // circular icon
            Container(
              width: 56 ,
              height: 56,
              padding: EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(
                color: dark ? CColors.dark : CColors.light,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(image: AssetImage(image), fit: BoxFit.cover),
                ),
              ),

            const SizedBox(height: CSizes.spaceBtwItems/2),
            // text 
            SizedBox(
              
              child: Text(
                title, 
                style: Theme.of(context).textTheme.labelMedium!.apply(color:textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                )), 
        
        
          ],
        ),
      ),
    );
  }
}

