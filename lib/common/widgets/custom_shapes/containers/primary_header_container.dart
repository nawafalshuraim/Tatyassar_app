import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:loom_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:loom_store/utils/constants/colors.dart';

class CPrimaryHeaderContainer extends StatelessWidget {
  const CPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CCurvedEdgeWidget(
      child: Container(
        color: CColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            child,
            Positioned(
              top: -100,
              right: -250,
              child: IgnorePointer(
                child: CCircularContianer(
                  backgroundcolor: CColors.textWhite.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: IgnorePointer(
                child: CCircularContianer(
                  backgroundcolor: CColors.textWhite.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
