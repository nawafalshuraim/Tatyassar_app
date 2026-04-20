import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatyassar/features/authentication/controllers/login/login_controller.dart';
import 'package:tatyassar/features/authentication/screens/passward_configuration/forget_passward.dart';
import 'package:tatyassar/features/authentication/screens/signup/signup.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/constants/text_strings.dart';
import 'package:tatyassar/utils/validators/validation.dart';

class CLoginForm extends StatelessWidget {
  const CLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
        child: Column(
          children: [
            // email
            TextFormField(
              controller: controller.email,
              validator: (value) => CValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: CTexts.email
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwInputFields),
            
            // password
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
            const SizedBox(height: CSizes.spaceBtwInputFields/2),
            
            // Remember me & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value, 
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value
                      )
                    ),
                    const Text(CTexts.rememberMe),
                  ],
                ),
                
                //forget password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassward()), 
                  child: const Text(CTexts.forgetPassword)
                ),
              ],
            ),
            const SizedBox(height: CSizes.spaceBtwSections),
            
            //sign in button
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(controller.loginFormKey), 
                child: const Text(CTexts.signIn)
              )
            ),
            
            const SizedBox(height: CSizes.spaceBtwItems),
            
            //create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()), 
                child: const Text(CTexts.createAccount)
              ),
            ),
          ],
        ),
      )
    );
  }
}