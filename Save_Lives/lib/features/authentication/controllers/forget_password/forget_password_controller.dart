import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
import 'package:bloodapp/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/helpers/network_manager.dart';
import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
import 'package:bloodapp/utilis/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  // Add your variables and methods here
  static ForgetPasswordController get instance => Get.find();

  // Example variable
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

   sendPasswordResetEmail() async 
   {
    try{
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your Request', TImages.docerAnimation);

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()) {
          TFullScreenLoader.stopLoading();
          return;
      }
      //Send Password Reset Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Stop Loading
      TFullScreenLoader.stopLoading();  

      //Show Success Message
      
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Password Reset Email Sent Successfully');

      //Redirect
      Get.to(() =>  ResetPassword(email: email.text.trim(),));
    } catch(e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();  

      //Show Error Message
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }

   }
   resendPasswordResetEmail(String email) async 
   {
    try{
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your Request', TImages.docerAnimation);

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
     
      //Send Password Reset Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Stop Loading
      TFullScreenLoader.stopLoading();  

      //Show Success Message
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Password Reset Email Sent Successfully');

      
    } catch(e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();  

      //Show Error Message
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
    

   }
}