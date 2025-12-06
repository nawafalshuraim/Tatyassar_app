import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/shimmer/shimmer.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/personalization/controllers/user_controller.dart';
import 'package:loom_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:loom_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: CAppBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              //profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final controller = UserController.instance;
                      final picture = controller.user.value.profilePicture;

                      if (controller.imageUploading.value) {
                        return const CShimmerEffect(
                            width: 80, height: 80, radius: 80);
                      }

                      if (picture.isEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(Icons.person,
                              size: 40, color: Colors.grey),
                        );
                      }

                      return CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: MemoryImage(
                          base64Decode(picture),
                        ),
                      );
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: Text('Change Profile Picture')),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),

              /// Heading Profile Info
              const CSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: CSizes.spaceBtwItems),

              CProfileMenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName())),
              CProfileMenu(
                  title: 'Username',
                  value: controller.user.value.username,
                  onPressed: () {}),

              const SizedBox(height: CSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),

              /// Heading Personal Info
              const CSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: CSizes.spaceBtwItems),

              CProfileMenu(
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onPressed: () {}),
              CProfileMenu(
                  title: 'E-mail',
                  value: controller.user.value.email,
                  onPressed: () {}),
              // CProfileMenu(
              //     title: 'Phone Number',
              //     value: controller.user.value.phoneNumber,
              //     onPressed: () {}),
              // CProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              // CProfileMenu(
              //     title: 'Date of Birth',
              //     value: '20 Feb, 2002',
              //     onPressed: () {}),
              const SizedBox(height: CSizes.spaceBtwItems),

              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text(
                      'close Account',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
