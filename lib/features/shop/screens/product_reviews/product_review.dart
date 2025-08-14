// //mport 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:loom_store/common/products/ratings/rating_indicator.dart';
// import 'package:loom_store/common/widgets/appbar/appbar.dart';
// import 'package:loom_store/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
// import 'package:loom_store/features/shop/screens/product_reviews/widgets/user_review_card.dart';
// import 'package:loom_store/utils/constants/sizes.dart';

// class ProductReviewScreen extends StatelessWidget {
//   const ProductReviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: CAppBar(
//         title: Text('Reviews & Ratings'),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(CSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Reviews and ratings are verified and are from people who recieved the same type of service'),
//               const SizedBox(height: CSizes.spaceBtwItems),

//               //overall product ratings
//               const COverallProductRating(),
//               const CRatingBarIndicator(rating: 3.5,),
//               Text('189', style: Theme.of(context).textTheme.bodySmall),
//               const SizedBox(height: CSizes.spaceBtwSections),

//               // user reviews list
//               const UserReviewCard(),
//               const UserReviewCard(),
//               const UserReviewCard(),
//               const UserReviewCard(),

//             ],
//           ),
//           ),
//       ),
//     );
//   }
// }



