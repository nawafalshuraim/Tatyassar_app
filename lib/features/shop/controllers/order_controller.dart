import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/login_signup/success_screen.dart/success_screen.dart';
import 'package:loom_store/data/repositories/authentication/authentication_repository.dart';
import 'package:loom_store/data/repositories/order/order_repositroy.dart';
import 'package:loom_store/features/personalization/controllers/address_controller.dart';
import 'package:loom_store/features/shop/controllers/cart_controller.dart';
import 'package:loom_store/features/shop/models/order_model.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/checkout_controller.dart';
import 'package:loom_store/navigation_menu.dart';
import 'package:loom_store/utils/constants/enums.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/popups/full_screen_loader.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      CLoaders.warningSnackBar(title: '!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      CFullScreenLoader.openLoadingDialog(
          'Processing your order', CImages.processingAnimation);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // Set Date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      ); // OrderModel

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      // Show Success screen
      Get.off(() => SuccessScreen(
            image: CImages.successfulPaymentIcon,
            title: 'Payment Success!',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
            subtitle: 'You will recieve your service soon',
          )); // SuccessScreen
    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: e.toString());
    }
  }
}
