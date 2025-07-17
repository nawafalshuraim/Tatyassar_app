import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loom_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:loom_store/features/personalization/screens/settings/settings.dart';
import 'package:loom_store/features/shop/screens/cart/cart.dart';
import 'package:loom_store/features/shop/screens/checkout/checkout.dart';
import 'package:loom_store/features/shop/screens/product_datails/product_detail.dart';
import 'package:loom_store/features/shop/screens/product_reviews/product_review.dart';
import 'package:loom_store/navigation_menu.dart';
import 'package:loom_store/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme, 
      darkTheme: CAppTheme.darkTheme, 
      home: const OnBoardingScreen(),

      
      
    );
  }
}
