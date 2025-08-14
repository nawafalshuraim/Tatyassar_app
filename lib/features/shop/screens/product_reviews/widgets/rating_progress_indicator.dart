import 'package:flutter/material.dart';
import 'package:loom_store/features/shop/screens/product_reviews/widgets/Projress_indicator.dart';

class COverallProductRating extends StatelessWidget {
  const COverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: Text('4.8', style: Theme.of(context).textTheme.displayLarge)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              CRatingProgressIndicator(text: '5', value: 1.0),
              CRatingProgressIndicator(text: '4', value: 0.8),
              CRatingProgressIndicator(text: '3', value: 0.6),
              CRatingProgressIndicator(text: '2', value: 0.4),
              CRatingProgressIndicator(text: '1', value: 0.2),
            ],
          ),
        )
    
      ],
    );
  }
}

