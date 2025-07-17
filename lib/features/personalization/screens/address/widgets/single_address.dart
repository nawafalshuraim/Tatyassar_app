import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CSingleAddress extends StatelessWidget {
  const CSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return CRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(CSizes.md),
      backgroundColor: selectedAddress
          ? CColors.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? CColors.darkGrey
              : CColors.grey, 
      margin: EdgeInsets.only(bottom: CSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5, 
            top: 0,

            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
               ? dark
                ? CColors.light
                : CColors.dark.withOpacity(0.6)
               : null,
              ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nawaf Alshammari',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CSizes.sm /2),
              Text(
                '0542076655',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: CSizes.sm /2),
              Text(
                'Riyadh, Al Aqiq, 14245',
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}
