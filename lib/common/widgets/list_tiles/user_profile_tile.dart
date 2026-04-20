import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatyassar/common/widgets/shimmer/shimmer.dart';
import 'package:tatyassar/features/personalization/controllers/user_controller.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'package:tatyassar/utils/constants/image_strings.dart';

class CUserProfileTile extends StatelessWidget {
  const CUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = UserController.instance;
      final user = controller.user.value;
      final base64Image = user.profilePicture;
      final hasBase64 = base64Image.isNotEmpty;

      return ListTile(
        leading: controller.imageUploading.value
            ? const CShimmerEffect(width: 50, height: 50, radius: 50)
            : CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade300,
                child: ClipOval(
                  child: hasBase64
                      ? Image.memory(
                          const Base64Decoder().convert(base64Image),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            CImages.user,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          CImages.user,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
        title: Text(
          user.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: CColors.white),
        ),
        subtitle: Text(
          user.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: CColors.white),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: CColors.white,
          ),
        ),
      );
    });
  }
}
