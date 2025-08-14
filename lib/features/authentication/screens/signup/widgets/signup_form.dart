import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/authentication/controllers/signup/singup_controller.dart';
import 'package:loom_store/features/authentication/screens/signup/widgets/Terms_Conditions_Checkbox.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';
import 'package:loom_store/utils/validators/validation.dart';

class CSignUpForm extends StatelessWidget {
  const CSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                // first name
                // controller & validator
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      CValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: CSizes.spaceBtwInputFields),
              Expanded(
                // last name
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      CValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          // username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                CValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          // email
          TextFormField(
            controller: controller.email,
            validator: (value) => CValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          // phone
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => CValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          // passward
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => CValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: CTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          // terms & conditions checkbox
          const CTermsAndConditionsCheckbox(),

          // sign Up button
          SizedBox(height: CSizes.spaceBtwSections),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(CTexts.createAccount))),
          SizedBox(height: CSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
