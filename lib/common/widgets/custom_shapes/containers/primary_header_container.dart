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
        color: const Color.fromARGB(255, 113, 131, 171), // Single background color (e.g. soft lavender)
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            // Decorations behind content
            Positioned(
              top: -100,
              right: -250,
              child: IgnorePointer(
                child: CCircularContianer(
                  backgroundcolor: const Color.fromARGB(255, 183, 183, 183).withOpacity(0.1),
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

            child,
          ],
        ),
      ),
    );
  }
}
