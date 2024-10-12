import 'package:bloodapp/data/repositories/user/user_repository.dart';
import 'package:bloodapp/features/personalization/models/user_models.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
// import 'package:bloodapp/data/repositories/user/user_repository.dart';
import 'package:bloodapp/features/authentication/screens/signup/verify_email.dart';
// import 'package:bloodapp/features/personalization/models/user_models.dart';
import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/helpers/network_manager.dart';
// import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
import 'package:bloodapp/utilis/popups/loaders.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  //Variables
  final hidePassword = true.obs; //Hide Password
  final checkbox = true.obs; //Checkbox
  final email = TextEditingController(); //Controller for Email
  final firstName = TextEditingController(); //Controller for First Name
  final lastName = TextEditingController(); //Controller for last Name
  final phoneNumber = TextEditingController(); //Controller for Phone Number
  final username = TextEditingController(); //Controller for First Name
  final password = TextEditingController(); //Controller for Password
  final useId = ''.obs; //User ID
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); //Form Key


 Future<void> signup() async {
  try {
    //start loading
    TFullScreenLoader.openLoadingDialog('We are processing your information',TImages.docerAnimation);

    //Check Internet Connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
       TFullScreenLoader.stopLoading();
      return;
    }
    //Form Validation
    if(!signupFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }
    //Privacy Policy Check
    if (!checkbox.value) {
      //Show Error Message
      TLoaders.errorSnackBar(title: 'Please accept the terms and conditions',message: 'You must accept the terms and conditions to continue');
       TFullScreenLoader.stopLoading();
      return;
    }
    //Register User in Firebase Authentication and Save User Data in Firebase
   UserCredential userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
    //Save Authenticated User Data in Firbase Firebloodapp
    final newUser = UserModel(
      id: userCredential.user!.uid,
      email: email.text.trim(),
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      username: username.text.trim(),
      profilePicture: '',
    );

    final userRepository = Get.put(UserRepository());
    await userRepository.saveUserRecord(newUser);

    //Send User Data to API
    await sendUserDetailsToApi(newUser);
    //Stop Loader
     TFullScreenLoader.stopLoading();
     
    //Show Success Message
    TLoaders.successSnackBar(title: 'Account Created Successfully',message: 'Please verify your email to continue');
    //Move to Verify Email Screen
    Get.to(() =>  VerifyEmailScreen(email: email.text.trim(),));

  } catch (e) {
    //Show Error Message
    // TLoaders.errorSnackBar(title: 'An error occurred, please try again',message:e.toString());
    // TFullScreenLoader.stopLoading();
     // Handle error more specifically
    String errorMessage = 'An unexpected error occurred, please try again.';
    if (e is FirebaseAuthException) {
      errorMessage = e.message ?? errorMessage; // Use specific error message if available
    }
   
  }
  // finally {
  //   //Remove Loader
  //   TFullScreenLoader.stopLoading();
  // }

 }
  // } finally {
  //   //Remove Loader
   
  //   }
}

Future<void> sendUserDetailsToApi(UserModel? userModel) async {
    
        

    try {
      // Create a UserModel from the user data
     

      // Prepare the user details for the API request
      Map<String, dynamic> userDetails = {
        'id': userModel?.id,
        'first_name': userModel?.firstName,
        'last_name': userModel?.lastName,
        'email': userModel?.email,
        'phone_number': userModel?.phoneNumber,
      };

      final response = await http.post(
        Uri.parse(APIConstants.tSecretAPIKey),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userDetails),
      );

      if (response.statusCode != 200) {
        throw 'Failed to create user in API: ${response.body}';
      }

      print("User details sent successfully!");
    } catch (e) {
      print('Error sending user details to API: $e');
      throw 'Error sending user details to API: $e';
    }
  }