// import 'package:flutter/material.dart';
// import 'package:loom_store/common/products/cart/add_remove_button.dart';
// import 'package:loom_store/common/widgets/appbar/appbar.dart';
// import 'package:loom_store/common/widgets/texts/product_price_text.dart';
// import 'package:loom_store/features/shop/screens/product_datails/widgets/product_meta_data.dart';
// import 'package:loom_store/features/shop/screens/product_datails/widgets/rating_share_widget.dart';
// import 'package:loom_store/utils/constants/sizes.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CAppBar(
//           title: Text('cart', style: Theme.of(context).textTheme.headlineSmall),
//           showBackArrow: true),

//       // products details
//       body: Padding(
//         padding: const EdgeInsets.all(CSizes.defaultSpace),
//         child: ListView.separated(
//           shrinkWrap: true,
//           separatorBuilder: (_, __) =>
//               const SizedBox(height: CSizes.spaceBtwItems/1.5),
//           itemCount: 4,
//           itemBuilder: (_, index) => Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         // rating and share
//                         CRatingAndShare(),
//                         CProductMetaData(),
//                         const SizedBox(height: CSizes.spaceBtwItems),

//                         // add, remove, and total
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CProductQuantityWithAddAndRemoveButton(),
//                             CProductpriceText(price: '560'),
//                           ],
//                         ),
//                          const SizedBox(height: CSizes.spaceBtwItems),
//                          Divider(),
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(CSizes.defaultSpace),
//         child:
//             ElevatedButton(onPressed: () {}, child: Text('Checkout SAR 800')),
//       ),
//     );
//   }
// }
