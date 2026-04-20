import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatyassar/app.dart';
import 'package:tatyassar/data/repositories/authentication/authentication_repository.dart';
import 'package:tatyassar/firebase_options.dart';


Future<void> main() async {
// add widgets binding (Flutter - iOS/Android )
final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

// add local storage (GetX)
await GetStorage.init();

 
// add await native splash until iteams load
FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// intialize firebase and athuentication repositoroy
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}
