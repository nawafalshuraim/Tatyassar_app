import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';
import 'package:loom_store/utils/validators/validation.dart';


class ForgetPassward extends StatelessWidget {
  const ForgetPassward({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: CAppBar(showBackArrow: true,),
      body: Padding(
        padding: EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //headings
            Text(CTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: CSizes.spaceBtwItems), 
            Text(CTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: CSizes.spaceBtwSections * 2), 

            // text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: CValidator.validateEmail,
                decoration: const InputDecoration(labelText: CTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections ), 
            
            // submit button
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: ()=> controller.sendPasswordResetEmail()  , child: const Text(CTexts.submit)))
          ],
        ),  

       ),
     );
  }
}