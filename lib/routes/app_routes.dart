import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tatyassar/features/chat/screens/chat_screen.dart';
import 'package:tatyassar/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: CRoutes.home, page: () => const ChatScreen()),
  ];
}
