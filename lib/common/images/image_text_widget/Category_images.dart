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
    this.isNetworkImage = true, 
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: CSizes.spaceBtwItems),
        child: Column(
          children: [
            // circular image
            Container(
              width: 55,
              height: 55,
              padding: const EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(
                color: dark ? CColors.dark : CColors.light,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(child: _buildImage()),
            ),
            const SizedBox(height: CSizes.spaceBtwItems / 2),

            // title
            SizedBox(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (image.isEmpty) {
      return const Icon(Icons.broken_image);
    }

    return isNetworkImage
        ? Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          )
        : Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          );
  }
}
