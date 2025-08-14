import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/device/device_utility.dart';

class CRatingProgressIndicator extends StatelessWidget {
  const CRatingProgressIndicator({
    super.key, required this.text, required this.value,
  });
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
          flex: 12,
          child: SizedBox(
            width: CDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: CColors.grey,
              valueColor: const AlwaysStoppedAnimation(CColors.primary),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
