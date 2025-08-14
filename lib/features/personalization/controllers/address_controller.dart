import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/texts/section_heading.dart';
import 'package:loom_store/data/repositories/address/address_repository.dart';
import 'package:loom_store/features/personalization/models/address_model.dart';
import 'package:loom_store/features/personalization/screens/address/add_new_address.dart';
import 'package:loom_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/cloud_helper_functions.dart';
import 'package:loom_store/utils/helpers/network_manager.dart';
import 'package:loom_store/utils/loaders/circular_loader.dart';
import 'package:loom_store/utils/popups/full_screen_loader.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  /// Select an address and update the selected field in DB
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const CCircularLoader(),
      );

      // Unselect current address if one is already selected
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      // Mark new address as selected
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(newSelectedAddress.id, true);
      Get.back(); // Close loading dialog
    } catch (e) {
      CLoaders.errorSnackBar(
          title: 'Error in selection', message: e.toString());
    }
  }

  /// Add new address and select it
  Future addNewAddresses() async {
    try {
      // Start loading
      CFullScreenLoader.openLoadingDialog(
          'Storing Address...', CImages.processingAnimation);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // Validate form
      if (!addressFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // Create address model
      final address = AddressModel(
        id: '',
        // name: name.text.trim(),
        // phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);
      address.id = id;

      // Select the new address
      await selectAddress(address);

      // Stop loading
      CFullScreenLoader.stopLoading();

      // Success message
      CLoaders.successSnackBar(
        title: 'Done',
        message: 'Your address has been saved successfully.',
      );

      // Refresh and reset
      refreshData.toggle();
      resetFormFields();

      // Close screen
      Navigator.of(Get.context!).pop();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  /// Show modal to select or add a new address
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(CSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CSectionHeading(
                    title: 'Select Address', showActionButton: false),
                const SizedBox(height: CSizes.spaceBtwItems),
                FutureBuilder<List<AddressModel>>(
                  future: getAllUserAddresses(),
                  builder: (_, snapshot) {
                    final response =
                        CCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot);
                    if (response != null) return response;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => CSingleAddress(
                        address: snapshot.data![index],
                        onTap: () async {
                          await selectAddress(snapshot.data![index]);
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: CSizes.defaultSpace * 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text('Add new address'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Clear input fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    addressFormKey.currentState?.reset();
  }
}
