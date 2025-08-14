import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/features/personalization/controllers/address_controller.dart';
import 'package:loom_store/features/personalization/models/address_model.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CSingleAddress extends StatelessWidget {
  const CSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;
    return Obx(
      (){
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
        onTap: onTap,
        child: CRoundedContainer(
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
                  // Text(
                  //   address.name,
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: Theme.of(context).textTheme.titleLarge,
                  // ),
                  const SizedBox(height: CSizes.lg /2),
                  // Text(
                  //   address.formattedPhoneNo,
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  const SizedBox(height: CSizes.sm /2),
                  Text(
                    address.toString(),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            ],
          ),
        ),
      ) ;
      }
    );
  }
}
