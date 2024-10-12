import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bloodapp/common/widgets/success_screen/success_screen.dart';

import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/constants/text_strings.dart';
import 'package:bloodapp/utilis/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  // Add your variables and methods 
  static VerifyEmailController get instance => Get.find();
//send Email Whenever Verify Screen appears and set Timer for auto redirect

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
    
  }
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Email Sent', message: 'We have sent you an email to verify your account');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
  setTimerForAutoRedirect()  {
    Timer.periodic(
      const Duration(seconds: 3),
    (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
        // Create UserModel from Firebase user

      if (user?.emailVerified ?? false ) {
     
        timer.cancel();
        await checkEmailVerificationStatus();
      
         Get.off(() => SuccessScreen(
          title: TTexts.yourAccountCreatedTitle,
           subtitle: TTexts.yourAccountCreatedSubTitle,
            image: TImages.successfullyRegistrationAnimation, 
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
            )
            );
      
       
      }   
    }
  
    );
  }
    checkEmailVerificationStatus() async {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser?.emailVerified ?? false) {
       
        Get.off(() => SuccessScreen(
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          image: TImages.successfullyRegistrationAnimation,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ));
        
      }
    }

  }

   




 
// import 'dart:async';
// import 'dart:convert';

// import 'package:bloodapp/features/personalization/models/user_models.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:bloodapp/common/widgets/success_screen/success_screen.dart';
// import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
// import 'package:bloodapp/utilis/constants/image_strings.dart';
// import 'package:bloodapp/utilis/constants/text_strings.dart';
// import 'package:bloodapp/utilis/popups/loaders.dart';

// class VerifyEmailController extends GetxController {
//   static VerifyEmailController get instance => Get.find();

//   @override
//   void onInit() {
//     sendEmailVerification();
//     setTimerForAutoRedirect();
//     super.onInit();
//   }

//   sendEmailVerification() async {
//     try {
//       await AuthenticationRepository.instance.sendEmailVerification();
//       TLoaders.successSnackBar(title: 'Email Sent', message: 'We have sent you an email to verify your account');
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Error', message: e.toString());
//     }
//   }

//   setTimerForAutoRedirect() {
//     Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) async {
//         await FirebaseAuth.instance.currentUser?.reload();
//         final user = FirebaseAuth.instance.currentUser;
//         if (user?.emailVerified ?? false) {
//           timer.cancel();
//           await checkEmailVerificationStatus(); // Ensure it checks here
//         }
//       },
//     );
//   }

//   checkEmailVerificationStatus() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser?.emailVerified ?? false) {
//       String? displayName = currentUser!.displayName;
//       String firstName = displayName != null ? displayName.split(' ')[0] : 'First Name'; // Fallback value
//       String lastName = displayName != null && displayName.split(' ').length > 1 ? displayName.split(' ')[1] : 'Last Name'; // Fallback value

//       await sendUserDetailsToApi(UserModel(
//         id: currentUser!.uid,
//         email: currentUser.email!,
//         firstName: firstName,
//         lastName: lastName,
//         phoneNumber: currentUser.phoneNumber ?? '',
//         username: "",
//         profilePicture: "",
//       ));
//       Get.off(() => SuccessScreen(
//         title: TTexts.yourAccountCreatedTitle,
//         subtitle: TTexts.yourAccountCreatedSubTitle,
//         image: TImages.successfullyRegistrationAnimation,
//         onPressed: () => AuthenticationRepository.instance.screenRedirect(),
//       ));
//     }
//   }

//   Future<void> sendUserDetailsToApi(UserModel user) async {
//     const String apiUrl = 'https://e758-2409-40f3-2b-7ab5-143a-79e2-7e02-b220.ngrok-free.app/users/'; // Replace with your API endpoint
//     try {
//       Map<String, dynamic> userDetails = {
//         'firebaseUserId': user.id,
//         'first_name': user.firstName, // Updated to match API requirement
//         'last_name': user.lastName, // Updated to match API requirement
//         'phone_number': user.phoneNumber, // Updated to match API requirement
//       };

//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(userDetails),
//       );

//       if (response.statusCode == 201) {
//         print("User details sent successfully!");
//       } else {
//         throw 'Failed to create user in API: ${response.body}';
//       }
//     } catch (e) {
//       throw 'Error sending user details to API: $e';
//     }
//   }
// }
