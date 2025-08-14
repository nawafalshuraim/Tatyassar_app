import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loom_store/features/personalization/screens/settings/settings.dart';
import 'package:loom_store/features/shop/screens/home/home.dart';
import 'package:loom_store/features/shop/screens/order/order.dart';
import 'package:loom_store/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
   final controller = Get.put(NavigationController());
   final dark = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
         ()=> NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected:(index) => controller.selectedIndex.value = index,
        backgroundColor: dark ? Colors.black : Colors.white,
        indicatorColor: dark ? Color.fromARGB(255, 113, 131, 171).withOpacity(0.2) : Color.fromARGB(255, 113, 131, 171).withOpacity(0.2),

        destinations: const [ 
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.receipt), label: 'Orders'),
          NavigationDestination(icon: Icon(Iconsax.gift), label: 'Promotions'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),  
      ),
     
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const HomeScreen(), const OrderScreen(), Container(), const SettingsScreen()];

  
}