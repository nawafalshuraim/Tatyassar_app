import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tatyassar/common/widgets/appbar/appbar.dart';
import 'package:tatyassar/common/widgets/login_signup/login_signup/social_button.dart';
import 'package:tatyassar/common/widgets/login_signup/login_signup/signup_form_divider.dart';
import 'package:tatyassar/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:tatyassar/utils/constants/sizes.dart';
import 'package:tatyassar/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
       ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(CTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: CSizes.spaceBtwSections),

              //form
               CSignUpForm(),
              // divider
              CSignUpDivider(dividerText: CTexts.orSignUpWith.capitalize!),
              SizedBox(height: CSizes.spaceBtwSections),


              // footer
              CSocialButton(),
              SizedBox(height: CSizes.spaceBtwSections),


            ],
          ),
        ),
      )
    );
  }
}

