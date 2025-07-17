import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:loom_store/common/widgets/rounded_images/rounded_image.dart';
import 'package:loom_store/features/shop/controllers/home_controller.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CPromoSlider extends StatelessWidget {
  const CPromoSlider({
    super.key, 
    required this.banners,
  });

  final List<String> banners;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index,_) => controller.updatePageIndicator(index),
          ),
          items: banners.map((url) => CRoundImage(imageUrl: url )). toList(),
        ),
        const SizedBox(height: CSizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // instead of repeating CCircularContian() block 3 times, use siple for loop
                for(int i = 0; i<banners.length;i++)
                CCircularContianer(
                 width:20,
                 height:4,
                 margin: EdgeInsets.only(right: 10),
                 backgroundcolor: controller.carouselControllerIndex.value == i ? CColors.primary : CColors.grey,
               )
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}

