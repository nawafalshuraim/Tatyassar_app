import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:loom_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:loom_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/personalization/screens/address/address.dart';
import 'package:loom_store/features/personalization/screens/profile/profile.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // header
          children: [
            CPrimaryHeaderContainer(
              child: Column(
                children: [
                  CAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: CColors.white),
                    ),
                  ),
                  const SizedBox(height: CSizes.spaceBtwSections),

                  // user profile card
                  CUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: CSizes.spaceBtwSections),
                ],
              ),
            ),

            // body
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  /// account settings
                  const CSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  CSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: ()=> Get.to(()=> const UserAddressScreen()) ,
                  ),
                  // const CSettingsMenuTile(
                  //   icon: Iconsax.shopping_cart,
                  //   title: 'My Cart',
                  //   subTitle: 'Add, remove services and move to checkout',
                  // ),
                  // const CSettingsMenuTile(
                  //   icon: Iconsax.bag_tick,
                  //   title: 'My Orders',
                  //   subTitle: 'In-progress and Completed Orders',
                  // ),
                  const CSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),
                  // const CSettingsMenuTile(
                  //   icon: Iconsax.discount_shape,
                  //   title: 'My Coupons',
                  //   subTitle: 'List of all the discounted coupons',
                  // ),
                  const CSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message',
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                  ),

                  /// app settings
                  const SizedBox(height: CSizes.spaceBtwSections),
                  const CSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: CSizes.spaceBtwItems),
                  const CSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firebase',
                  ),
                  CSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  CSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// Logout Button
                  const SizedBox(height: CSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
                  ), // Size
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
