import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loom_store/bindings/general_bindings.dart';
import 'package:loom_store/routs/app_routs.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      // Circular Progress Indicator meanwhile authentication repository is deciding to show the relevent screen.
      home: const Scaffold(
          backgroundColor: CColors.primary,
          body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}
