import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
//import 'package:loom_store/common/products/cart/cart_menu_icon.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/text_strings.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CTexts.homeAppbarTitle,
            style: Theme.of(context).textTheme.labelMedium!.apply(color: CColors.grey),
          ),
          Text(
            CTexts.homeAppbarSubTitle,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: CColors.white),
          ),
        ],
      ),
      // actions: [
      //   CCartCounterIcon(onPressed: () {  }, iconColor: CColors.white,),
      // ],
    );
  }
}
