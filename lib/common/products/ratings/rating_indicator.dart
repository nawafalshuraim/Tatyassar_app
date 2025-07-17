import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/utils/constants/colors.dart';

class CRatingBarIndicator extends StatelessWidget {
  const CRatingBarIndicator({
    super.key, 
    required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: CColors.grey,
      itemBuilder: (_,__) => const Icon(Iconsax.star1, color: CColors.primary,));
  }
}

