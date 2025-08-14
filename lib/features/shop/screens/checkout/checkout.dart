import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/products/checkout_cart/coupon_widget.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:loom_store/common/widgets/texts/product_price_text.dart';
import 'package:loom_store/features/personalization/controllers/address_controller.dart';
import 'package:loom_store/features/shop/controllers/cart_controller.dart';
import 'package:loom_store/features/shop/controllers/order_controller.dart';
import 'package:loom_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/pricing_calculator.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = CPricingCalculator.calculateTotalPrice(subTotal);
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
                    CBillingPaymentSection(),
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
    onPressed: () {
      final addressController = AddressController.instance;

      if (subTotal <= 0) {
        CLoaders.warningSnackBar(
          title: 'Empty Cart', 
          message: 'Add items to the cart in order to proceed.',
        );
        return;
      }

      if (addressController.selectedAddress.value.id.isEmpty) {
        CLoaders.warningSnackBar(
          title: 'No Address Selected', 
          message: 'Please select a delivery address before checkout.',
        );
        return;
      }

      // If both checks pass → proceed with the order
      orderController.processOrder(totalAmount);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pay ',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        CProductpriceText(
          price: totalAmount.toStringAsFixed(2),
          showCurrencyIcon: true,
          isLarge: false,
          color: Colors.white,
        ),
      ],
    ),
  ),
)

);

    
  }
}
