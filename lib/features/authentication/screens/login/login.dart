import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/styles/spacing_styles.dart';
import 'package:loom_store/common/widgets/login_signup/login_signup/login_form_divider.dart';
import 'package:loom_store/common/widgets/login_signup/login_signup/social_button.dart';
import 'package:loom_store/features/authentication/screens/login/widgets/login_form.dart';
import 'package:loom_store/features/authentication/screens/login/widgets/login_header.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // logo, title, subtitle
             const CLoginHeader(),

             //form
             const CLoginForm(),

             // divider
            CLoginDivider(dividerText: CTexts.orSignInWith.capitalize!),
            const SizedBox(height: CSizes.spaceBtwSections),

             // footer
             const CSocialButton (),



           ],    
          ),
          ),
        ),
      );
  }
}


