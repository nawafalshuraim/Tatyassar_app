import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatyassar/common/widgets/appbar/appbar.dart';
import 'package:tatyassar/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:tatyassar/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:tatyassar/data/repositories/authentication/authentication_repository.dart';
import 'package:tatyassar/utils/popups/loaders.dart';
import 'package:tatyassar/features/personalization/screens/profile/profile.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'package:tatyassar/utils/constants/sizes.dart';

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
                  // const CSectionHeading(
                  //     title: 'Account Settings', showActionButton: false),
                  // const SizedBox(height: CSizes.spaceBtwItems),

                  // CSettingsMenuTile(
                  //   icon: Iconsax.location,
                  //   title: 'My Addresses',
                  //   subTitle: 'Where you want to recieve your service',
                  //   onTap: () => Get.to(() => const UserAddressScreen()),
                  // ),
              

                  

                  /// Logout Button
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                          try {
                            await AuthenticationRepository.instance.logout();
                          } catch (e) {
                            CLoaders.errorSnackBar(title: 'Error', message: e.toString());
                          }
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
