import 'package:get/get.dart';
import 'package:loom_store/features/personalization/controllers/address_controller.dart';
import 'package:loom_store/features/shop/screens/checkout/widgets/checkout_controller.dart';
import 'package:loom_store/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}