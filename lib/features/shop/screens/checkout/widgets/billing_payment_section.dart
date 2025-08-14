import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/checkout_controller.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CBillingPaymentSection extends StatelessWidget {
  const CBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController()); 
    final dark = CHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CSectionHeading(
          title: "Payment Method",
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),
        Obx(
          () {
            final method = controller.selectedPaymentMethod.value;

            return Row(
              children: [
                CRoundedContainer(
                  width: 60,
                  height: 35,
                  padding: const EdgeInsets.all(CSizes.sm),
                  backgroundColor: dark ? CColors.light : CColors.white,
                  child: Image(
                    image: AssetImage(method.image),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: CSizes.spaceBtwItems / 2),
                Text(
                  method.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
