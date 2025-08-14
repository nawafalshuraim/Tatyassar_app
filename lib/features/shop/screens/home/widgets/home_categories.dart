import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/images/image_text_widget/Category_images.dart';
import 'package:loom_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:loom_store/features/shop/controllers/category_controller.dart';
import 'package:loom_store/features/shop/screens/home/widgets/home_sub_categories.dart';

class CHomeCategories extends StatelessWidget {
  const CHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
        


    return Obx(() {
      if (categoryController.isLoading.value) return const CCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text('No Data Found!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white)));
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return CVerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => 
               SubCategoriesScreen(category: category)
              ),
                    
                    
                  
            );
          },
        ), 
      ); 
    });
  }
}
