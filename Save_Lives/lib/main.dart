// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }

// Flutter imports:
import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
import 'package:bloodapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Package imports:
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:get_storage/get_storage.dart';

// Project imports:
import 'app.dart';

// import 'package:store/data/repositories/authentication/authentication_repository.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:get/get.dart';

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //Initialize Local Storage
  await GetStorage.init();
  //Await Splash until other  items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Intialize FireBase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
     );
 
  runApp(const MyApp());

}

