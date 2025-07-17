import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';

class CUserProfileTile extends StatelessWidget {
  const CUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: CCircularContianer(
        image: CImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text("Nawaf Alshammari",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: CColors.white)),
      subtitle: Text("Alshuraim20@gmail.com",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: CColors.white)),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: CColors.white,
        ),
      ),
    );
  }
}
