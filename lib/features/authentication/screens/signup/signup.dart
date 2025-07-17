import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:loom_store/common/widgets/login_signup/login_signup/login_form_divider.dart';
import 'package:loom_store/common/widgets/login_signup/login_signup/login_form_footer.dart';
import 'package:loom_store/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:loom_store/utils/constants/sizes.dart';
import 'package:loom_store/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              CLoginDivider(dividerText: CTexts.orSignUpWith.capitalize!),
              SizedBox(height: CSizes.spaceBtwSections),


              // footer
              CLoginFooter(),
              SizedBox(height: CSizes.spaceBtwSections),


            ],
          ),
        ),
      )
    );
  }
}

