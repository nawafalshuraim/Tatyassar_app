import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class CLoaders {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: CHelperFunctions.isDarkMode(Get.context!) ? CColors.darkerGrey.withOpacity(0.9) : CColors.grey.withOpacity(0.9),
          ),
          child: Center(child: Text(message, style: Theme.of(Get.context!).textTheme.labelLarge)),
        ),
      ),
    );
  }

  static successSnackBar({required title, message = '', duration = 3}) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 92, 172, 105),
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        content: Row(
          children: [
            const Icon(Iconsax.check, color: CColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  if (message.toString().isNotEmpty)
                    Text('$message', style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static warningSnackBar({required title, message = ''}) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        content: Row(
          children: [
            const Icon(Iconsax.warning_2, color: CColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  if (message.toString().isNotEmpty)
                    Text('$message', style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static errorSnackBar({required title, message = ''}) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade600,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        content: Row(
          children: [
            const Icon(Iconsax.warning_2, color: CColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  if (message.toString().isNotEmpty)
                    Text('$message', style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
