import 'dart:convert';

import 'package:bloodapp/features/personalization/models/user_models.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ProfileController extends GetxController {
  var isLoading = true.obs;
  var user = UserModel(id: '', firstName: '', lastName: '', email: '', phoneNumber: '',username: '',profilePicture: '').obs;
  var currentUserDetails = {}.obs;
  var userRequests = [].obs;
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    getUserProfile(userId!) ; // Pass the user's ID here
  }




   Future<void> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('${APIConstants.userApi}$userId'));
   
         // Wrap in a list
         
    if (response.statusCode == 200) {
       currentUserDetails.value = jsonDecode(response.body);
        userRequests.value = [currentUserDetails]; 
        isLoading.value = false;

         print("User Requests: ${userRequests}");
    } else {
      throw Exception("Failed to load user profile");
    }
   }



  // Method to update the profile by making an API call
  Future<void> updateProfile(String firstName, String lastName, String email, String phoneNumber) async {
    // Prepare the updated data
    var updatedData = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber
    };
    print("Updated Data: $updatedData");

    try {
      // Make the PUT request to your FastAPI backend
      var response = await http.put(
        Uri.parse('${APIConstants.userApi}$userId'), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        // Update userRequests with the new data if API call is successful
        userRequests[0]['first_name'] = firstName;
        userRequests[0]['last_name'] = lastName;
        userRequests[0]['email'] = email;
        userRequests[0]['phone_number'] = phoneNumber;

        // Notify the UI
        update();
      } else {
        // Handle error response
        print('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error occurred while updating profile: $e');
    }
  }
}