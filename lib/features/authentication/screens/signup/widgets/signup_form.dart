import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/authentication/screens/signup/verify_email.dart';
import 'package:loom_store/features/authentication/screens/signup/widgets/Terms_Conditions_Checkbox.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';

class CSignUpForm extends StatelessWidget {
  const CSignUpForm({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {

    return Form(child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                  labelText: CTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
    
            const SizedBox(width: CSizes.spaceBtwInputFields),
    
            Expanded(
              child: TextFormField(
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
                expands: false,
                decoration: const InputDecoration(
                  labelText: CTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit),
                ),
              ),
          const SizedBox(height: CSizes.spaceBtwInputFields),
    
          // email
          TextFormField(
                expands: false,
                decoration: const InputDecoration(
                  labelText: CTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
          const SizedBox(height: CSizes.spaceBtwInputFields),
    
          // phone
          TextFormField(
                expands: false,
                decoration: const InputDecoration(
                  labelText: CTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
          const SizedBox(height: CSizes.spaceBtwInputFields),
    
          // passward
          TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: CTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: Icon(Iconsax.eye_slash),
                ),
              ),
          const SizedBox(height: CSizes.spaceBtwInputFields),
    
          // terms & conditions checkbox
          const CTermsAndConditionsCheckbox(),

          // sign Up button
          SizedBox(height: CSizes.spaceBtwSections),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.to(()=> const VerifyEmailScreen()), child: const Text( CTexts.createAccount))),
          SizedBox(height: CSizes.spaceBtwSections),
    
      ],
    ),
    );
  }
}

