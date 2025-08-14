import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/products/product_cards/product_card_vertical.dart';
import 'package:loom_store/common/widgets/layout/grid_layout.dart';
import 'package:loom_store/features/shop/controllers/all_products_controller.dart';
import 'package:loom_store/features/shop/models/product_model.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

import '../../../utils/constants/sizes.dart';

class CSortableProducts extends StatelessWidget {
  const CSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    final isDarkMode = CHelperFunctions.isDarkMode(context);
    controller.asssignProducts(products);
    return Column(
      children: [
        /// Dropdown
       DropdownButtonFormField2<String>(
  decoration: InputDecoration(
    prefixIcon: Icon(Iconsax.sort, color: isDarkMode ? Colors.white70 : Colors.black54),
    hintText: 'Sort by...',
    hintStyle: TextStyle(color: isDarkMode ? Colors.white60 : Colors.black54),
    filled: true,
    fillColor: isDarkMode ? Colors.grey[850] : Colors.grey[100],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: isDarkMode ? Colors.white24 : Colors.black26,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: isDarkMode ? Colors.white24 : Colors.black26,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: isDarkMode ? Colors.white70 : Colors.black87,
        width: 2,
      ),
    ),
  ),
  value: controller.selectedSortOption.value.isEmpty ? null : controller.selectedSortOption.value,
  onChanged: (value) {
    controller.sortProducts(value!);
  },
  style: TextStyle(
    color: isDarkMode ? Colors.white : Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  dropdownStyleData: DropdownStyleData(
    offset: const Offset(0,-3), // (x,y) coordinate postion for the dropdown menu itself
    maxHeight: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
        )
      ],
    ),
  scrollbarTheme: ScrollbarThemeData(
    thumbVisibility: MaterialStateProperty.all(true),  // shows scrollbar always
    thickness: MaterialStateProperty.all(6),
    radius: const Radius.circular(15),
  ),
  ),
  items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Popularity']
      .map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          ))
      .toList(),
),

        const SizedBox(height: CSizes.spaceBtwSections),

        /// Products
        Obx(() => CGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                CProductCardVertical(product: controller.products[index]))),
      ],
    );
  }
}
