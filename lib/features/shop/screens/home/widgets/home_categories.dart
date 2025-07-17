import 'package:flutter/material.dart';
import 'package:loom_store/common/images/image_text_widget/Category_images.dart';
import 'package:loom_store/utils/constants/image_strings.dart';

class CHomeCategories extends StatelessWidget {
  const CHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return CVerticalImageText(
            image: CImages.carpenter,
            title: 'carpenter',
            onTap: () {},
          );
        },
      ),
    );
  }
}
