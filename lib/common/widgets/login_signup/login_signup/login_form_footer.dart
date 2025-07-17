import 'package:flutter/material.dart';
import 'package:loom_store/utils/constants/colors.dart';
import 'package:loom_store/utils/constants/image_strings.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class CLoginFooter extends StatelessWidget {
  const CLoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
         decoration: BoxDecoration(border: Border.all(color: CColors.grey), borderRadius: BorderRadius.circular(100)),
         child: IconButton(
           onPressed: (){}, 
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