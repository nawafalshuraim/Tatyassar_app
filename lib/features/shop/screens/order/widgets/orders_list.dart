import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class COrderListItems extends StatelessWidget {
  const COrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return  ListView.separated(
      separatorBuilder: (_,index) => const SizedBox(height: CSizes.spaceBtwItems,),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (_,index) => CRoundedContainer( 
        showBorder: true,
        padding: EdgeInsets.all(CSizes.md),
        backgroundColor: dark ? CColors.dark : CColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //row 1
            Row(
              children: [
                Icon(Iconsax.car),
                const SizedBox(width: CSizes.spaceBtwItems /2),
      
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Processing', style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.primary, fontWeightDelta: 1)),
                      Text('July 14, 2025', style: Theme.of(context).textTheme.headlineSmall),
                  
                    ],
                  ),
                ),
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34, size: CSizes.iconSm,))
              ],
      
            ),
            SizedBox(height: CSizes.spaceBtwItems),
      
            //row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Iconsax.tag),
                      const SizedBox(width: CSizes.spaceBtwItems /2),
                  
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order', style: Theme.of(context).textTheme.labelMedium),
                            Text('#265N2', style: Theme.of(context).textTheme.titleMedium),
                        
                          ],
                        ),
                      ),
                    ],
                  
                  ),
                ),
      
                Expanded(
                  child: Row(
                    children: [
                      Icon(Iconsax.calendar),
                      const SizedBox(width: CSizes.spaceBtwItems /2),
                  
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date', style: Theme.of(context).textTheme.labelMedium),
                            Text('July 14, 2025', style: Theme.of(context).textTheme.titleMedium),
                        
                          ],
                        ),
                      ),
                    ],
                  
                  ),
                ),
              ],
            )
          ],
        ),
      
      
      ),
    );
  }
}