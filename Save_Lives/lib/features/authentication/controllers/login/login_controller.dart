import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/helpers/network_manager.dart';
import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
import 'package:bloodapp/utilis/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
// import 'package:bloodapp/utilis/constants/image_strings.dart';
// import 'package:bloodapp/utilis/helpers/network_manager.dart';
// import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
// import 'package:bloodapp/utilis/popups/loaders.dart';


class LoginController extends GetxController {
  // static LoginController get instance => Get.find();

  final localStorage = GetStorage();

  final   emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
  try {
    TFullScreenLoader.openLoadingDialog('Logging you in ...', TImages.docerAnimation);

    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
       TFullScreenLoader.stopLoading();
      return;
    }
    //Form Validation
    if(!loginformKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }
    //Privacy Policy Check
    if (!rememberMe.value) {
     localStorage.write('Remember_me_email', emailController.text.trim());
     localStorage.write('Remember_me_password', passwordController.text.trim());
    }
    final userCredential = await AuthenticationRepository.instance.signInWithEmailAndPassword(
 emailController.text.trim(),
       passwordController.text.trim(),
    );
    TFullScreenLoader.stopLoading();
    //Redirect
    AuthenticationRepository.instance.screenRedirect();
  } 
  catch(e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Error', message: e.toString());  
  }
}
}

 

