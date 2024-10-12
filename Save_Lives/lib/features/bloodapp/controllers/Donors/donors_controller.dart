
import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/features/bloodapp/screens/home/home.dart';

import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:bloodapp/utilis/helpers/network_manager.dart';
import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
import 'package:bloodapp/utilis/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class DonorsController extends GetxController {
  static DonorsController get instance => Get.find();
 
  //Variables
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController lastDonationDateController = TextEditingController();
  // String userId = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
   Future<void> addDonor() async {

   try {
     TFullScreenLoader.openLoadingDialog('We are processing your information',TImages.docerAnimation);
    //Check Internet Connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }
    //Form Validation
    if (!formKey.currentState!.validate()) {
       TFullScreenLoader.stopLoading();
      return;
    }
    print('Form is valid');
     final User? user = FirebaseAuth.instance.currentUser;

     
  
    //Get User ID
    
    //Check if user ID is empty

    // if (userId.isEmpty || userId == null) {
    //   TFullScreenLoader.stopLoading();
    //   TLoaders.errorSnackBar(title: 'Error', message: 'User ID not found. Please log in again.');
    //   return;
    // }
    // String? userId = Get.find<String>(tag: 'userId');

    if (user == null || user.uid.isEmpty) {
      TLoaders.errorSnackBar(title: 'Error', message: 'User ID not found. Please log in again.');
      return;
    }
    //Send Data to Backend using Api
    final donor = DonorModel(
      id: user.uid,
      firstName: '',
      bloodGroup: bloodGroupController.text.trim(),
      gender: genderController.text.trim(),
      state: stateController.text.trim(),
      district: districtController.text.trim(),
      pinCode: pinCodeController.text.trim(),
      address: addressController.text.trim(),
      contactNumber: contactNumberController.text.trim(),
      );
    //Send Data to Backend
    print('Sending donor data to backend');
    print('User ID: ${user.uid}');
    await sendDonorData(donor, user);
    print('Donor data sent to backend');

   //Stop Loader
     TFullScreenLoader.stopLoading();
       //Show Success Message
    TLoaders.successSnackBar(title: 'Account Created Successfully',message: 'Please verify your email to continue');
    //Navigate to Verify Email Screen
    Get.to(() => const HomeScreen());
    
   } catch (e) {
    //Show Error Message
    TLoaders.errorSnackBar(title: 'An error occurred, please try again',message:e.toString());
    TFullScreenLoader.stopLoading();
     // Handle error more specifically
  }
}

}
 // Assuming ApiConstants.donorsApi is the correct endpoint

Future<void> sendDonorData(DonorModel donor, User useId) async {
  
    final url = Uri.parse(APIConstants.donorsapi);

    try {
      // Prepare the donor data as JSON
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
            
          'id': useId.uid,
          
          'blood_group': donor.bloodGroup,
          'gender': donor.gender,
          'state': donor.state,
          'district': donor.district,
          'pin_code': donor.pinCode,
          'address': donor.address,
          'contact_number': donor.contactNumber,
          
        }),
        
      );
      print('Response body: ${response.body}');


      // Check if the request was successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Data successfully sent
        print('Donor information submitted successfully');
      } else {
        // Handle failure
        print('Failed to submit donor information. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions during the request
      print('Error sending donor data: $e');
    }
}

