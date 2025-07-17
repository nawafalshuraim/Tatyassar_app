import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/features/personalization/screens/address/add_new_address.dart';
import 'package:loom_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() =>  const AddNewAddressScreen()),
        backgroundColor: CColors.primary,
        child: const Icon(Iconsax.add, color: CColors.white),
      ),
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              CSingleAddress(selectedAddress: false),
              CSingleAddress(selectedAddress: true),
            ],
          ),
        ),
      ),
    );
  }
}
