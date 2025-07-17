import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loom_store/common/products/cart/coupon_widget.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/login_signup/success_screen.dart/success_screen.dart';
import 'package:loom_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:loom_store/navigation_menu.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CAppBar(
        title: Text('Order Review'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // items in the cart
              const CCartItems(showAddRemoveButtons: false),
              const SizedBox(height: CSizes.spaceBtwSections),

              // coupon
              CCouponCode(),
              const SizedBox(height: CSizes.spaceBtwSections),

              // billing
              CRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(CSizes.md),
                backgroundColor: dark ? CColors.black : CColors.white,
                child: Column(
                  children: [
                    //pricing
                    CBillingAmountSection(),
                    const SizedBox(height: CSizes.spaceBtwItems),
                    //divider
                    const Divider(),
                    const SizedBox(height: CSizes.spaceBtwItems),
                    // payment methods
                    CBillingPaymnetSection(),
                    const SizedBox(height: CSizes.spaceBtwItems),
                    // address
                    CBillingAddressSection()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => SuccessScreen(
                  image: CImages.successfulPaymentIcon,
                  title: 'Payment Success',
                  subtitle: 'You will recieve your service soon!',
                  onPressed: () => Get.offAll(() => const NavigationMenu())
                )),
            child: Text('Checkout SAR 560')),
      ),
    );
  }
}
