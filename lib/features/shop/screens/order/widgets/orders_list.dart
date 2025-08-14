import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/features/shop/controllers/order_controller.dart';
import 'package:loom_store/features/shop/screens/order/widgets/order_review_screen.dart';
import 'package:loom_store/navigation_menu.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/cloud_helper_functions.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
import 'package:loom_store/utils/loaders/animation_loader.dart';

class COrderListItems extends StatelessWidget {
  const COrderListItems({super.key});

  @override
Widget build(BuildContext context) {
  final controller = Get.put(OrderController());
  return FutureBuilder(
    future: controller.fetchUserOrders(),
    builder: (_, snapshot) {
      /// Nothing Found Widget
      final emptyWidget = CAnimationLoaderWidget(
        text: 'No Orders Yet!',
        animation: CImages.processingAnimation,
        showAction: true,
        actionText: 'fill it',
        onActionPressed: () => Get.offAll(() => const NavigationMenu()),
      );

      /// helper Function: Handle Loader, No Record, OR ERROR Message
      final response = CCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
      if (response != null) return response;

      /// congratulations record found.
      final orders = snapshot.data!;
      return ListView.separated(
        shrinkWrap: true,
        itemCount: orders.length,
        separatorBuilder: (_, index) => const SizedBox(height: CSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          final order = orders[index];
          return CRoundedContainer(
            padding: EdgeInsets.all(8),
            showBorder: true,
            backgroundColor: CHelperFunctions.isDarkMode(context) ? CColors.dark : CColors.light,
            child: Column(
              children: [
                // top Row
                Row(
                  children: [
                    // image
                    const Icon(Iconsax.car),
                    const SizedBox(width: CSizes.spaceBtwItems / 2),

                    // status and date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.orderStatusText,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.primary, fontWeightDelta: 1),
                          ), 
                          Text(order.formattedOrderDate, style: Theme.of(context).textTheme.headlineSmall),
                        ],
                      ),
                    ), 
                    
                    // icon // to be edited
                    IconButton(onPressed: () => Get.to(OrderReviewScreen(order: order,)), icon: const Icon(Iconsax.arrow_right_34, size: CSizes.iconSm)),
                  ],
                ), 
                const SizedBox(height: CSizes.spaceBtwItems),

                /// bottom row
                Row(
                  children: [
                    /// order No.
                    Expanded(
                      child: Row(
                        children: [
                          /// icon
                          const Icon(Iconsax.tag),
                          const SizedBox(width: CSizes.spaceBtwItems / 2),

                          /// order
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelMedium,
                                ), 
                                Text(
                                  order.id,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ), 
                              ],
                            ), 
                          ), 
                        ],
                      ), 
                    ), 

                    // arriving date
                    Expanded(
                      child: Row(
                        children: [
                          // icon
                          const Icon(Iconsax.calendar_1),
                          const SizedBox(width: CSizes.spaceBtwItems / 2),

                          /// status and date
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Arriving Date',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelMedium,
                                ), 
                                Text(
                                  order.formattedDeliveryDate,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ), 
                              ],
                            ), 
                          ), 
                        ],
                      ), 
                    ), 
                  ],
                ), 
              ],
            ), 
          ); 
        },
      ); 
    },
  ); 
}
}