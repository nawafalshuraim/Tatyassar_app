import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/personalization/controllers/address_controller.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CBillingAddressSection extends StatelessWidget {
  const CBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CSectionHeading(
          title: "Address",
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),

        Obx(() {
          final selected = addressController.selectedAddress.value;
          if (selected.id.isEmpty) {
            return Text('Select Address',
                style: Theme.of(context).textTheme.bodyMedium);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(selected.name,
              //     style: Theme.of(context).textTheme.bodyLarge),
              // const SizedBox(height: CSizes.spaceBtwItems / 2),
              
              Row(
                children: [
                  // const Icon(Icons.phone, color: Colors.grey, size: 16),
                  // const SizedBox(width: CSizes.spaceBtwItems),
                  // Text(selected.phoneNumber,
                  //     style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(Icons.location_history,
                      color: Colors.grey, size: 16),
                  const SizedBox(width: CSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      '${selected.city}, ${selected.street}, ${selected.postalCode}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
