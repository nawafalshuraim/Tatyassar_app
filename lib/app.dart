import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tatyassar/bindings/general_bindings.dart';
import 'package:tatyassar/features/chat/screens/chat_screen.dart';
import 'package:tatyassar/routes/app_routes.dart';
import 'package:tatyassar/utils/theme/theme.dart';

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
      home: const ChatScreen(),
    );
  }
}
