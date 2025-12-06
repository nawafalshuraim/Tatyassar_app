import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/shimmer/shimmer.dart';
import 'package:loom_store/features/personalization/controllers/user_controller.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/text_strings.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({
    super.key,
  });

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
              );
            }
          }),
          
        ],
      ),
    );
  }
}
