import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:loom_store/features/shop/screens/home/home.dart';
import 'package:loom_store/routs/routs.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: CRoutes.home, page: () => HomeScreen()),
    // Add more GetPage entries as needed
  ];
}