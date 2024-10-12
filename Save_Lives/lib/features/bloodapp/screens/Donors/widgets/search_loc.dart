import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/donors_loc_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> _showSearchDialog(BuildContext context) async {
    String? location;
    await showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Enter Location'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Location'),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                location = controller.text.trim();
                Navigator.of(context).pop();
               
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
    return location;
  }

  Future<void> serachloaction(BuildContext context) async {
  String? location = await _showSearchDialog(context);
  if (location != null && location.isNotEmpty) {
    try {
      print('Searching for donors in $location');
      List<DonorModel> donors = await searchDonors(location);
      if (donors.isNotEmpty) {
        // Navigate to a new page to display donor details
        Get.to(DonorListPage(donors: donors, location: location));
      } else {
        // Show no donors found message
        Get.snackbar('No Results', 'No donors found for this location.');
      }
    } catch (e) {
      // Handle exceptions during the search
      Get.snackbar('Error', 'Failed to search for donors: $e');
    }
  }
}