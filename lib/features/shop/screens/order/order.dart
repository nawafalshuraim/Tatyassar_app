import 'package:flutter/material.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';
import 'package:loom_store/features/shop/screens/order/widgets/orders_list.dart';
import 'package:loom_store/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: CAppBar(title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall),showBackArrow: false,),
      body: const Padding(
        padding: EdgeInsets.all(CSizes.defaultSpace),
        
        
        child: COrderListItems(),
      ), 
    ); 
  }
}