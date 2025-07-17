import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/authentication/screens/passward_configuration/forget_passward.dart';
import 'package:loom_store/features/authentication/screens/signup/signup.dart';
import 'package:loom_store/navigation_menu.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';

class CLoginForm extends StatelessWidget {
  const CLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
      child: Column(
       children: [
      
         // email
         TextFormField(
           decoration: const InputDecoration(
             prefixIcon: Icon(Iconsax.direct_right),
             labelText: CTexts.email
           ),
         ),
         const SizedBox(height: CSizes.spaceBtwInputFields),
      
         // passward
         TextFormField(
           decoration: const InputDecoration(
             prefixIcon: Icon(Iconsax.password_check),
             labelText: CTexts.password,
             suffixIcon: Icon(Iconsax.eye_slash)
           ),
         ),
         const SizedBox(height: CSizes.spaceBtwInputFields/2),
      
         // Remember me & forget passward
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             // Remember me
             Row(
               children: [
                 Checkbox(value: true, onChanged: (value){}),
                 const Text(CTexts.rememberMe),
               ],
             ),
      
             //forget passward
             TextButton(onPressed: ()=> Get.to(()=> const ForgetPassward()), child: const Text(CTexts.forgetPassword)),
           ],
         ),
         const SizedBox(height: CSizes.spaceBtwSections),
      
         //sign in button
         SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.to(()=> NavigationMenu()), child: Text(CTexts.signIn))),
    
         const SizedBox(height: CSizes.spaceBtwItems),
    
         //create acount button
         SizedBox(width: double.infinity,
          child: OutlinedButton(onPressed: () => Get.to(() => const SignUpScreen()), child: Text(CTexts.createAccount))
          ),               
      
       ],
      ),
    )
    );
  }
}

