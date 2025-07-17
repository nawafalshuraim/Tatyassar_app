import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CAppBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              //profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CCircularContianer(image: CImages.user, width: 80, height: 80),
                    TextButton(onPressed: (){}, child:  Text('Change Profile Picture')),
                  ],
                ),
              ),
              /// Details
const SizedBox(height: CSizes.spaceBtwItems / 2),
const Divider(),
const SizedBox(height: CSizes.spaceBtwItems),

/// Heading Profile Info
const CSectionHeading(title: 'Profile Information', showActionButton: false),
const SizedBox(height: CSizes.spaceBtwItems),

CProfileMenu(title: 'Name', value: 'Nawaf Alshammari', onPressed: () {}),
CProfileMenu(title: 'Username', value: 'nawaf369', onPressed: () {}),

const SizedBox(height: CSizes.spaceBtwItems),
const Divider(),
const SizedBox(height: CSizes.spaceBtwItems),

/// Heading Personal Info
const CSectionHeading(title: 'Personal Information', showActionButton: false),
const SizedBox(height: CSizes.spaceBtwItems),

CProfileMenu(title: 'User ID', value: '45689',icon: Iconsax.copy, onPressed: () {}),
CProfileMenu(title: 'E-mail', value: 'Alshuraim20@gmail.com', onPressed: () {}),
CProfileMenu(title: 'Phone Number', value: '0542076655', onPressed: () {}),
CProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
CProfileMenu(title: 'Date of Birth', value: '20 Feb, 2002', onPressed: () {}),
const SizedBox(height: CSizes.spaceBtwItems),

Center(
  child: TextButton(
    onPressed: (){}, child: const Text('close Account', style: TextStyle(color: Colors.red),)),
),
            ],
          ),

        ),

      ),
    );
  }
}

