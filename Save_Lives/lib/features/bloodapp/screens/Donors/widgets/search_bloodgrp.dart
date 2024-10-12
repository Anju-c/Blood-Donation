import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/donors_bloodgroup_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> _showBloodGroupDialog(BuildContext context) async {
    String? bloodGroup;
    await showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Enter Blood Group'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Blood Group'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                bloodGroup = controller.text.trim();
                
                Navigator.of(context).pop();
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
      
    );
  
    return bloodGroup;
  }

  Future<void> searchbloodgroup(BuildContext context) async {
  String? bloodGroup = await _showBloodGroupDialog(context);
   
  if (bloodGroup != null && bloodGroup.isNotEmpty) {
    try {
      print('Searching for donors with blood group: $bloodGroup');
      List<DonorModel> donors = await searchDonorsByBloodGroup(bloodGroup);
      
      if (donors.isNotEmpty) {
        // Navigate to a new page to display donor details
        Get.to(DonorListPageBlood(donors: donors, bloodgroup: bloodGroup));
      } else {
        // Show no donors found message
        Get.snackbar('No Results', 'No donors found with this blood group.');
      }
    } catch (e) {
      // Handle exceptions during the search
      Get.snackbar('Error', 'Failed to search for donors: $e');
    }
  }
}
