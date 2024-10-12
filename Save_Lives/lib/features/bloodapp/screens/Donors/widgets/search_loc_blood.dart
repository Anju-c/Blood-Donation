import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/donors_loc_blood_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<Map<String, String?>?> _showSearchDialog(BuildContext context) async {
  String? location;
  String? bloodGroup;

  await showDialog(
    context: context,
    builder: (context) {
      TextEditingController locationController = TextEditingController();
      TextEditingController bloodGroupController = TextEditingController();
      
      return AlertDialog(
        title: const Text('Enter Search Criteria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,  // Ensure the dialog adjusts to its content size
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(hintText: 'Location'),
            ),
            const SizedBox(height: 10),  // Add some spacing between the two fields
            TextField(
              controller: bloodGroupController,
              decoration: const InputDecoration(hintText: 'Blood Group'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              location = locationController.text.trim();
              bloodGroup = bloodGroupController.text.trim();
              print('Location: $location, Blood Group: $bloodGroup');
              Navigator.of(context).pop();  // Close the dialog
            },
            child: const Text('Search'),
          ),
        ],
      );
    },
  );

  // Return both location and blood group as a map
  return {
    'location': location,
    'bloodGroup': bloodGroup,
  };
}

// Future<void> searchbloodgroupandlocation(BuildContext context) async {
//   Map<String, String?>? searchCriteria = await _showSearchDialog(context);

//   if (searchCriteria != null) {
//     String? location = searchCriteria['location'];
//     String? bloodGroup = searchCriteria['bloodGroup'];

//     // Check if either location or blood group is provided
//     if ((location != null && location.isNotEmpty) || 
//         (bloodGroup != null && bloodGroup.isNotEmpty)) {
//       try {
//         print('Searching for donors with location: $location and blood group: $bloodGroup');
        
//         // Call your search function with both location and blood group
//         List<DonorModel> donors = await searchDonorslocBgp( location, bloodGroup);
        
//         if (donors.isNotEmpty) {
//           // Navigate to a new page to display donor details
//           Get.to(DonorListPageBloodAndLocation(donors: donors, location: location, bloodGroup: bloodGroup));
//         } else {
//           // Show no donors found message
//           Get.snackbar('No Results', 'No donors found matching the criteria.');
//         }
//       } catch (e) {
//         // Handle exceptions during the search
//         Get.snackbar('Error', 'Failed to search for donors: $e');
//       }
//     } else {
//       // Show an error if no search criteria were provided
//       Get.snackbar('Error', 'Please provide at least a location or blood group to search.');
//     }
//   }
// }
Future<void> searchDonorsByCriteria(BuildContext context) async {
   Map<String, String?>? searchCriteria = await _showSearchDialog(context);
   String? location = searchCriteria?['location'];
   print('Location: $location');
  String? bloodGroup = searchCriteria?['bloodGroup'];
print('Blood Group: $bloodGroup');

  if ((location != null && location.isNotEmpty) || (bloodGroup != null && bloodGroup.isNotEmpty)) {
    try {
      print('Searching for donors in $location with blood group $bloodGroup');
      List<DonorModel> donors = await searchDonorslocBgp(location, bloodGroup);
      if (donors.isNotEmpty) {
        // Navigate to a new page to display donor details
        Get.to(DonorListPageBloodAndLocation(donors: donors, location: location, bloodGroup: bloodGroup));
      } else {
        // Show no donors found message
        Get.snackbar('No Results', 'No donors found for the given criteria.');
      }
    } catch (e) {
      // Handle exceptions during the search
      Get.snackbar('Error', 'Failed to search for donors: $e');
    }
  } else {
    Get.snackbar('Error', 'Please provide either location, blood group, or both.');
  }
}
