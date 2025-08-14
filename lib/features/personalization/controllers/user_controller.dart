import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loom_store/data/repositories/authentication/authentication_repository.dart';
import 'package:loom_store/data/repositories/user%20/user_repository.dart';
import 'package:loom_store/features/authentication/models/user_model.dart';
import 'package:loom_store/features/authentication/screens/login/login.dart';
import 'package:loom_store/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/helpers/network_manager.dart';
import 'package:loom_store/utils/popups/full_screen_loader.dart';
import 'package:loom_store/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  // loader while fetching
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final hidePassword = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
  // // save user record from any registeration provider, google facebook....
  // Future<void> saveUserRecord(UserCredential? userCredentials) async {
  //   try {
  //     // ***REFRESH USER RECORD****
  //     await fetchUserRecord()
  //     if (userCredentials != null) {
  //       // convert name to first and last name
  //       final nameParts =
  //           UserModel.nameParts(userCredentials.user!.displayName ?? '');
  //       final userName =
  //           UserModel.generateUsername(userCredentials.user!.displayName ?? '');

  //       // map data
  //       final user = UserModel(
  //         id: userCredentials.user!.uid,
  //         firstName: nameParts[0],
  //         lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
  //         username: userName,
  //         email: userCredentials.user!.email ?? '',
  //         phoneNumber: userCredentials.user!.phoneNumber ?? '',
  //         profilePicture: userCredentials.user!.photoURL ?? '',
  //       );

  //       // save user data
  //       await userRepository.saveUserRecord(user);

  //     }
  //   } catch (e) {
  //     CLoaders.successSnackBar(
  //         title: 'Data not saved',
  //         message:
  //             'something went wrong while saving your information, you can resave your data in your profile.');
  //   }
  // }

  // Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored..
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      CLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(CSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
            child: Text('Delete')),
      ), // ElevatedButton
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ), // OutlinedButton
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      CFullScreenLoader.openLoadingDialog(
          'Processing', CImages.processingAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          CFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          CFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.warningSnackBar(title: 'Sorry', message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      CFullScreenLoader.openLoadingDialog(
          'Processing', CImages.processingAnimation);

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      CFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.warningSnackBar(title: 'Sorry', message: e.toString());
    }
  }

//upload usser image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxWidth: 512,
          maxHeight: 512);
      if (image != null) {
        // upload image
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);
        // update image
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        CLoaders.successSnackBar(
            title: 'Done', message: 'Your profile image has been updated!');
      }
    } catch (e) {
      CLoaders.errorSnackBar(title: '!', message: 'something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
