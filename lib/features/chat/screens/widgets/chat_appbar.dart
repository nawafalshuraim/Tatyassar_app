import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatyassar/common/widgets/appbar/appbar.dart';
import 'package:tatyassar/common/widgets/shimmer/shimmer.dart';
import 'package:tatyassar/features/personalization/controllers/user_controller.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'package:tatyassar/utils/constants/text_strings.dart';

class CChatAppBar extends StatelessWidget {
  const CChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return CAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: CColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const CShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                      color: CColors.white,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            }
          }),
        ],
      ),
    );
  }
}
