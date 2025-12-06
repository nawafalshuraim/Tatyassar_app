import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/personalization/screens/settings/settings.dart';
import 'package:loom_store/features/shop/screens/home/home.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: dark ? Colors.black : Colors.white,
          indicatorColor: dark
              ? const Color.fromARGB(255, 113, 131, 171).withOpacity(0.2)
              : const Color.fromARGB(255, 113, 131, 171).withOpacity(0.2),

          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const ChatScreen(),     
    const SettingsScreen(),
  ];
}
