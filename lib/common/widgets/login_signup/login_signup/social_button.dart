import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loom_store/features/authentication/controllers/login/login_controller.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CSocialButton extends StatelessWidget {
  const CSocialButton ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Get.put = new(creating instance) Getx feature
    final controller = Get.put(LoginController());

    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
         decoration: BoxDecoration(border: Border.all(color: CColors.grey), borderRadius: BorderRadius.circular(100)),
         child: IconButton(
           onPressed: ()=> controller.googleSignIn(), 
           icon: const Image(
             width: CSizes.iconMd,
             height: CSizes.iconMd,
             image: AssetImage(CImages.google),
           ),
           ),
       ),
    
     ],
    );
  }
}