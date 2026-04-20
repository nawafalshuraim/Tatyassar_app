import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatyassar/features/personalization/screens/settings/settings.dart';
import 'package:tatyassar/features/chat/screens/chat_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: const Color.fromARGB(255, 113, 131, 171).withValues(alpha: 0.2),

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
