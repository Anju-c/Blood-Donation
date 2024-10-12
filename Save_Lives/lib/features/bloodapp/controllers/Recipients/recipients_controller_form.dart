import 'package:bloodapp/features/bloodapp/models/recipient_details.dart';
import 'package:bloodapp/features/bloodapp/screens/home/home.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/helpers/network_manager.dart';
import 'package:bloodapp/utilis/popups/full_screen_loaders.dart';
import 'package:bloodapp/utilis/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RecipientController extends GetxController {
  static RecipientController get instance => Get.find();
  // Variables
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController attendeeNameController = TextEditingController();
  final TextEditingController attendeeContactNumberController = TextEditingController();
  final TextEditingController requiredDateController = TextEditingController();
  final TextEditingController selectUnitsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  RxBool isCritical = false.obs; // To handle the critical toggle
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> addRecipient() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are processing your information', TImages.docerAnimation);
      
      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      print('Form is valid');
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null || user.uid.isEmpty) {
        TLoaders.errorSnackBar(title: 'Error', message: 'User ID not found. Please log in again.');
        return;
      }
      // Send Data to Backend using API
      final recipient = RecipientModel(
        id: user.uid,
        bloodGroup: bloodGroupController.text.trim(),
        patientName: patientNameController.text.trim(),
        attendeeName: attendeeNameController.text.trim(),
        attendeePhoneNumber: attendeeContactNumberController.text.trim(),
        requiredDate: requiredDateController.text.trim(),
        selectUnits: selectUnitsController.text.trim(),
        location: locationController.text.trim(),
       
      );
      // Send Data to Backend
      print('Sending recipient data to backend');
      await sendRecipientData(recipient, user);
      print('Recipient data sent to backend');
      // Stop Loader
      TFullScreenLoader.stopLoading();
      // Show Success Message
      TLoaders.successSnackBar(title: 'Recipient Registered Successfully', message: 'Data has been submitted');
      
      // Navigate to Home Screen
      Get.to(() => const HomeScreen());
    } catch (e) {
      // Show Error Message
      TLoaders.errorSnackBar(title: 'An error occurred, please try again', message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}
// Send Recipient Data to API
Future<void> sendRecipientData(RecipientModel recipient, User user) async {
  final url = Uri.parse(APIConstants.recipientsApi);
  try {
    // Prepare the recipient data as JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id': user.uid,
        'blood_group': recipient.bloodGroup,
        'patient_name': recipient.patientName,
        'attendee_name': recipient.attendeeName,
      
        'attendee_contact_number': recipient.attendeePhoneNumber,
        'required_date': recipient.requiredDate,
        'selected_units': recipient.selectUnits,
        'location': recipient.location,
        // 'is_critical': recipient.isCritical,
      }),
    );
    print('Response body: ${response.body}');
    // Check if the request was successful
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Recipient information submitted successfully');
    } else {
      print('Failed to submit recipient information. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions during the request
    print('Error sending recipient data: $e');
  }
}
