import 'package:bloodapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bloodapp/features/bloodapp/controllers/Recipients/recipients_controller.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RecipientScreen extends StatelessWidget {
  const RecipientScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final RecipientControllerForm recipientController = Get.put(RecipientControllerForm());
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    // Using DefaultTabController to manage tab switching without needing a TabController in a StatelessWidget.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Text(
              'Recipients',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          bottom:  TabBar(
            onTap: (index) {
              // Fetch the appropriate data based on the tab index
              if (index == 0) {
                recipientController.fetchUserDetailsById(userId!);
              } else if (index == 1) {
                recipientController.fetchRecipientDetails();
              }
            },
            labelColor: TColors.primaryColor,
            unselectedLabelColor: TColors.grey,
            indicatorColor: Colors.red,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'User Requests'),
              Tab(text: 'Recipient Details'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TabBarView(
            children: [
              // First Tab: User Requests for Blood
              Obx(() {
                if (recipientController.isLoadingUserRequests.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (recipientController.userRequests.isEmpty) {
                  return const Center(child: Text('No user requests found.'));
                }
                return ListView.builder(
                  itemCount: recipientController.userRequests.length,
                  itemBuilder: (context, index) {
                    print(index);
                    // if (index == 0) {
                    //   recipientController.fetchUserDetailsById(userId!); // Ensure userId is valid here
                    // }
                    final recipient = recipientController.userRequests[index];
                    print(recipient);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TRoundedContainer(
                        width: double.infinity,
                        height: 200,
                        showBorder: true,
                        backgroundColor: dark ? TColors.primaryColor : TColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Image(
                                    image: AssetImage('assets/img/request-removebg-preview.png'),
                                    height: 100,
                                    width: 80,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Iconsax.user, color: Colors.white),
                                          Text(
                                            '${recipient['patient_name']}',
                                            style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Iconsax.location, color: Colors.white),
                                          Text(
                                            '${recipient['location']}, Kerala, India',
                                            style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Iconsax.heart, color: Colors.white),
                                          Text(
                                            ' ${recipient['blood_group']}',
                                            style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showUpdateDialog(context, recipient);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Iconsax.edit, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text('Update', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      recipientController.deleteRecipient(recipient['id']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Iconsax.trash, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text('Cancel', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              // Second Tab: Recipient Details
              Obx(() {
                if (recipientController.isLoadingRecipients.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (recipientController.recipientDetails.isEmpty) {
                  return const Center(child: Text('No recipients found.'));
                }
                return ListView.builder(
                  itemCount: recipientController.recipientDetails.length,
                  itemBuilder: (context, index) {
                  //   if (index == 1) {
                  // recipientController.fetchRecipientDetails(); // Ensure userId is valid here
                  //   }
                    
                    final recipient = recipientController.recipientDetails[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TRoundedContainer(
                        width: double.infinity,
                        height: 150,
                        showBorder: true,
                        backgroundColor: dark ? TColors.primaryColor : TColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Image(
                                image: AssetImage('assets/img/request-removebg-preview.png'),
                                height: 100,
                                width: 80,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Iconsax.user, color: Colors.white),
                                      Text(
                                        ' ${recipient.patientName}',
                                        style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Iconsax.location, color: Colors.white),
                                      Text(
                                        '${recipient.location}, Kerala, India',
                                        style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Iconsax.heart, color: Colors.white),
                                      Text(
                                        ' ${recipient.bloodGroup}',
                                        style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, dynamic recipient) {
    final RecipientControllerForm recipientController = Get.find<RecipientControllerForm>();
    TextEditingController contactController = TextEditingController(text: recipient['attendee_contact_number']);
    TextEditingController locationController = TextEditingController(text: recipient['location']);
    TextEditingController unitsController = TextEditingController(text: recipient['selected_units'].toString());
    TextEditingController dateController = TextEditingController(text: recipient['required_date']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Recipient"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contactController,
                decoration: const InputDecoration(hintText: 'Contact Number'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(hintText: 'Location'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: unitsController,
                decoration: const InputDecoration(hintText: 'Required Units'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(hintText: 'Required Date'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> updatedData = {
                  'attendee_contact_number': contactController.text,
                  'location': locationController.text,
                  'selected_units': unitsController.text,
                  'required_date': dateController.text,
                };

                await recipientController.updateRecipient(recipient['id'], updatedData);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}