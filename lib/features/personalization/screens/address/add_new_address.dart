import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/features/personalization/controllers/address_controller.dart';
import 'package:loom_store/features/personalization/screens/address/widgets/map_with_current_location_screen.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
import 'package:loom_store/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const CAppBar(
        showBackArrow: true,
        title: Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Form(
          key: controller.addressFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Section Heading
              Text(
                "Address Details",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: CSizes.spaceBtwItems),

              /// Street & Postal Code
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                      validator: (value) =>
                          CValidator.validateEmptyText('Street', value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.location),
                        labelText: 'Street',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: CSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                      validator: (value) =>
                          CValidator.validateEmptyText('Postal Code', value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.code),
                        labelText: 'Postal Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: CSizes.spaceBtwInputFields),

              /// City
              TextFormField(
                controller: controller.city,
                validator: (value) =>
                    CValidator.validateEmptyText('City', value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.building),
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: CSizes.defaultSpace),

              /// Divider (between manual fields and map selection)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? CColors.darkGrey : Colors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text('OR'.capitalize!,
                      style: Theme.of(context).textTheme.labelMedium),
                  Flexible(
                    child: Divider(
                      color: dark ? CColors.darkGrey : Colors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 55,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: CSizes.defaultSpace),

              /// Map Selection Field Style
              InkWell(
                onTap: () async {
                  try {
                    final placemark = await Get.to<Placemark>(
                      () => MapWithCurrentLocationScreen(),
                    );

                    if (placemark != null) {
                      controller.street.text = placemark.street ?? '';
                      controller.city.text = placemark.locality ?? '';
                      controller.postalCode.text = placemark.postalCode ?? '';

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Address autofilled from selected location'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No location selected')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to get location: $e')),
                    );
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.map),
                      labelText: 'Select Location on Map',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: CSizes.defaultSpace + 80),
            ],
          ),
        ),
      ),

      /// Save Button fixed at bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: CColors.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: () => controller.addNewAddresses(),
          label: const Text(
            'Save Address',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
