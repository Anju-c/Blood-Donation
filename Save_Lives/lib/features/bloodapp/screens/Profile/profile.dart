// import 'package:bloodapp/features/bloodapp/controllers/profile/profile_controller.dart';
// import 'package:bloodapp/features/bloodapp/screens/Profile/widget/profilecard.dart';
// import 'package:bloodapp/utilis/constants/colors.dart';
// import 'package:bloodapp/utilis/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ProfileController profileController = Get.put(ProfileController());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Profile",
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         centerTitle: true,
//         backgroundColor: TColors.primaryColor, // Use a theme or brand color
//       ),
//       body: Obx(() {
//         if (profileController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           final userRequests = profileController.userRequests[0];
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(TSizes.defaultSpace),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Profile Avatar
//                 Center(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.redAccent.withOpacity(0.3),
//                     child: const Icon(Icons.person, size: 50, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // User Details Section
//                 ProfileInfoCard(
//                   title: "First Name",
//                   value: userRequests['first_name'],
//                   icon: Icons.person,
//                 ),
//                 ProfileInfoCard(
//                   title: "Last Name",
//                   value: userRequests['last_name'],
//                   icon: Icons.person_outline,
//                 ),
//                 ProfileInfoCard(
//                   title: "Email",
//                   value: userRequests['email'],
//                   icon: Icons.email,
//                 ),
//                 ProfileInfoCard(
//                   title: "Phone",
//                   value: userRequests['phone_number'],
//                   icon: Icons.phone,
//                 ),
//                 const SizedBox(height: 20),

//                 // Additional Action Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         // Show the edit popup
//                         _showEditDialog(context, profileController, userRequests);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Iconsax.edit, color: Colors.white),
//                           SizedBox(width: 10),
//                           Text('Edit', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Logout functionality
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Iconsax.logout_15, color: Colors.white),
//                           SizedBox(width: 10),
//                           Text('Logout', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }

//   // Method to show the edit profile dialog
//   void _showEditDialog(BuildContext context, ProfileController profileController, Map<String, dynamic> userRequests) {
//     final TextEditingController firstNameController = TextEditingController(text: userRequests['first_name']);
//     final TextEditingController lastNameController = TextEditingController(text: userRequests['last_name']);
//     final TextEditingController emailController = TextEditingController(text: userRequests['email']);
//     final TextEditingController phoneController = TextEditingController(text: userRequests['phone_number']);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Edit Profile'),
//           content: Form(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: firstNameController,
//                     decoration: const InputDecoration(labelText: 'First Name'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your first name';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: lastNameController,
//                     decoration: const InputDecoration(labelText: 'Last Name'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your last name';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: emailController,
//                     decoration: const InputDecoration(labelText: 'Email'),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty || !value.contains('@')) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: phoneController,
//                     decoration: const InputDecoration(labelText: 'Phone Number'),
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Save updated profile
//                 profileController.updateProfile(
//                   firstNameController.text,
//                   lastNameController.text,
//                   emailController.text,
//                   phoneController.text,
//                 );
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:bloodapp/data/repositories/authentication/authentication_repository.dart';
import 'package:bloodapp/features/bloodapp/controllers/profile/profile_controller.dart';
import 'package:bloodapp/features/bloodapp/screens/Profile/widget/profilecard.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: TColors.primaryColor, // Use a theme or brand color
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Properly casting the RxMap to Map<String, dynamic>
          final userRequests = profileController.userRequests[0].cast<String, dynamic>();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Avatar
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.redAccent.withOpacity(0.3),
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // User Details Section
                ProfileInfoCard(
                  title: "First Name",
                  value: userRequests['first_name'],
                  icon: Icons.person,
                ),
                ProfileInfoCard(
                  title: "Last Name",
                  value: userRequests['last_name'],
                  icon: Icons.person_outline,
                ),
                ProfileInfoCard(
                  title: "Email",
                  value: userRequests['email'],
                  icon: Icons.email,
                ),
                ProfileInfoCard(
                  title: "Phone",
                  value: userRequests['phone_number'],
                  icon: Icons.phone,
                ),
                const SizedBox(height: 20),

                // Additional Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Show the edit popup
                        _showEditDialog(context, profileController, userRequests);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Iconsax.edit, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Edit', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await   AuthenticationRepository.instance.logout();

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Iconsax.logout_15, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Logout', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  // Method to show the edit profile dialog
  void _showEditDialog(BuildContext context, ProfileController profileController, Map<String, dynamic> userRequests) {
    final TextEditingController firstNameController = TextEditingController(text: userRequests['first_name']);
    final TextEditingController lastNameController = TextEditingController(text: userRequests['last_name']);
    final TextEditingController emailController = TextEditingController(text: userRequests['email']);
    final TextEditingController phoneController = TextEditingController(text: userRequests['phone_number']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save updated profile
                profileController.updateProfile(
                  firstNameController.text,
                  lastNameController.text,
                  emailController.text,
                  phoneController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
