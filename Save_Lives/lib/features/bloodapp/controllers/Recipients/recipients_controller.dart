import 'dart:convert';
import 'package:bloodapp/features/bloodapp/models/recipient_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bloodapp/utilis/constants/api_constants.dart';


class RecipientControllerForm extends GetxController {
  // Observable lists to store user requests and recipient details
  var userRequests = [].obs;
  var recipientDetails = <RecipientModel>[].obs;
  
  // Loading states
  var isLoadingUserRequests = true.obs;
  var isLoadingRecipients = true.obs;
   String? userId = FirebaseAuth.instance.currentUser?.uid;
  // Fetch user details by userId
  var currentUserDetails = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetailsById(userId!);
    fetchRecipientDetails();
  }

  // Fetch details of the current user by userId
  Future<void> fetchUserDetailsById(String userId) async {
    isLoadingUserRequests(true);
    try {
      final response = await http.get(Uri.parse('${APIConstants.recipientsApi}$userId'));
       // Append userId to URL
       print("Response: ${response.body}");
      if (response.statusCode == 200) {
        currentUserDetails.value = jsonDecode(response.body);
        userRequests.value = [currentUserDetails]; 
         // Wrap in a list
         print("User Requests: ${userRequests}");
      
     
      } else {
        Get.snackbar('Error', 'Failed to load user details');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user details');
    } finally {
      isLoadingUserRequests(false);
    }
  }
  

  // Fetch recipient details from the backend
  Future<void> fetchRecipientDetails() async {
    isLoadingRecipients(true);
    try {
      final response = await http.get(Uri.parse(APIConstants.recipientsApi)); // Replace with actual URL
      if (response.statusCode == 200) {
        List<dynamic> recipientJson = jsonDecode(response.body);
        recipientDetails.value = recipientJson.map((json) => RecipientModel.fromJson(json)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load recipient details');
    } finally {
      isLoadingRecipients(false);
    }
  }

  Future<void> updateRecipient(String recipientId, Map<String, dynamic> updatedData) async {
    final String url = '${APIConstants.recipientsApi}$recipientId';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed, like Authorization
        },
        body: json.encode(updatedData),
      );
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        // Update the local list with the updated recipient details
        var updatedRecipient = json.decode(response.body);
        
        // Find the index of the recipient being updated
        int index = userRequests.indexWhere((rec) => rec['id'] == recipientId);
        if (index != -1) {
          userRequests[index] = updatedRecipient; // Update the user requests list
        }

        // Optionally, refresh recipient details as well
        await fetchUserDetailsById(recipientId); 
        // Fetch updated recipient details if needed
        await fetchRecipientDetails(); // Fetch updated recipient details if needed

        Get.snackbar('Success', 'Recipient updated successfully.');
      } else {
        Get.snackbar('Error', 'Failed to update recipient.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

    // Method to delete a recipient by ID
  Future<void> deleteRecipient(String recipientId) async {
    try {
      final response = await http.delete(
        Uri.parse('${APIConstants.recipientsApi}$recipientId'), // Adjust the API URL as necessary
      );

      if (response.statusCode == 200) {
        // Remove the recipient from the list locally
        userRequests.removeWhere((request) => request['id'] == recipientId);
        recipientDetails.removeWhere((recipient) => recipient.id == recipientId);
        Get.snackbar('Success', 'Recipient request deleted successfully.');
      } else {
        Get.snackbar('Error', 'Failed to delete recipient request.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete recipient request.');
    }
  }
}


