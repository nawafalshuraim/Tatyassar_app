import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/payment_method_model.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Apple Pay', image: CImages.applePay);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CSectionHeading(
                  title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: CSizes.spaceBtwSections),
              CPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Appple Pay', image: CImages.applePay)),
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              CPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Visa', image: CImages.visa)),
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              CPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Mastercar', image: CImages.masterCard)),
              const SizedBox(height: CSizes.spaceBtwItems / 2),

              
              
              
            ],
          ),
        ),
      ),
    );
  }
}
