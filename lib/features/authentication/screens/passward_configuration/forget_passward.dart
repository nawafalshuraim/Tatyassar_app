import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/authentication/screens/passward_configuration/reset_passward.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';


class ForgetPassward extends StatelessWidget {
  const ForgetPassward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            TextFormField(
              decoration: const InputDecoration(labelText: CTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
            ),
            const SizedBox(height: CSizes.spaceBtwSections ), 
            
            // submit button
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: ()=> Get.off(()=> const ResetPassward()), child: const Text(CTexts.submit)))
          ],
        ),
        
            

       ),
     );
  }
}