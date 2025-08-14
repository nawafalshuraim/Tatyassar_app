import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:loom_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:loom_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/data/repositories/authentication/authentication_repository.dart';
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

                  // user profile tile
                  CUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
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
                    icon: Iconsax.location,
                    title: 'My Addresses',
                    subTitle: 'Where you want to recieve your service',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.card,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),

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

                  /// Logout Button
                  const SizedBox(height: CSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                          await AuthenticationRepository.instance.logout();
                        },
                        child: const Text('Logout')),
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
