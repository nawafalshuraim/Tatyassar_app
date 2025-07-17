import 'package:flutter/material.dart';
//import 'package:loom_store/common/products/cart/cart_menu_icon.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: const Text('store'),
        actions: [
          //CCartCounterIcon(onPressed: (){}),
        ],
      ),
    );
  }
}